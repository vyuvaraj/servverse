package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"os/exec"
	"os/signal"
	"path/filepath"
	"strings"
	"sync"
	"syscall"
	"time"
)

var version = "dev"

type Service struct {
	Name    string
	Binary  string
	Port    string
	Args    []string
	process *exec.Cmd
}

var allServices = []Service{
	{Name: "ServGate", Binary: "servgate", Port: "8080"},
	{Name: "ServStore", Binary: "servstore", Port: "8081"},
	{Name: "ServQueue", Binary: "servqueue", Port: "8082"},
	{Name: "ServConsole", Binary: "servconsole", Port: "8083"},
	{Name: "ServCache", Binary: "servcache", Port: "8084"},
	{Name: "ServCron", Binary: "servcron", Port: "8085"},
	{Name: "ServCloud", Binary: "servcloud", Port: "8086"},
	{Name: "ServMesh", Binary: "servmesh", Port: "8087"},
	{Name: "ServRegistry", Binary: "servregistry", Port: "8088"},
	{Name: "ServTrace", Binary: "servtrace", Port: "8090"},
	{Name: "ServMail", Binary: "servmail", Port: "8094"},
	{Name: "ServFlow", Binary: "servflow", Port: "8096"},
	{Name: "ServDB", Binary: "servdb", Port: "8097"},
	{Name: "ServAuth", Binary: "servauth", Port: "8098"},
	{Name: "ServTunnel", Binary: "servtunnel", Port: "8443"},
}

func main() {
	if len(os.Args) < 2 {
		printUsage()
		os.Exit(1)
	}

	switch os.Args[1] {
	case "up":
		cmdUp()
	case "status":
		cmdStatus()
	case "version":
		fmt.Printf("servverse %s\n", version)
	case "help", "--help", "-h":
		printUsage()
	default:
		fmt.Fprintf(os.Stderr, "Unknown command: %s\n", os.Args[1])
		printUsage()
		os.Exit(1)
	}
}

func printUsage() {
	fmt.Println("servverse — Unified launcher for the Serv ecosystem")
	fmt.Println()
	fmt.Println("Commands:")
	fmt.Println("  up [--only name1,name2]   Start all (or selected) services")
	fmt.Println("  status                    Check health of all services")
	fmt.Println("  version                   Print version")
	fmt.Println()
	fmt.Println("Examples:")
	fmt.Println("  servverse up")
	fmt.Println("  servverse up --only servgate,servstore,servqueue")
	fmt.Println("  servverse status")
}

func cmdUp() {
	// Parse --only flag
	services := allServices
	for i, arg := range os.Args[2:] {
		if arg == "--only" && i+1 < len(os.Args[2:]) {
			names := strings.Split(os.Args[2:][i+1], ",")
			services = filterServices(names)
			break
		}
	}

	binDir := getBinDir()
	var wg sync.WaitGroup
	var running []*exec.Cmd

	fmt.Printf("Starting %d services...\n\n", len(services))

	for i := range services {
		svc := &services[i]
		binaryPath := filepath.Join(binDir, svc.Binary+getExt())

		if _, err := os.Stat(binaryPath); os.IsNotExist(err) {
			fmt.Printf("  %-14s SKIP (binary not found)\n", svc.Name)
			continue
		}

		args := append([]string{"--port", svc.Port}, svc.Args...)
		cmd := exec.Command(binaryPath, args...)
		cmd.Stdout = nil
		cmd.Stderr = nil

		if err := cmd.Start(); err != nil {
			fmt.Printf("  %-14s FAILED (%v)\n", svc.Name, err)
			continue
		}

		svc.process = cmd
		running = append(running, cmd)
		fmt.Printf("  %-14s started on :%s (PID %d)\n", svc.Name, svc.Port, cmd.Process.Pid)

		wg.Add(1)
		go func(c *exec.Cmd, name string) {
			defer wg.Done()
			c.Wait()
		}(cmd, svc.Name)
	}

	fmt.Printf("\n%d services running. Press Ctrl+C to stop all.\n", len(running))

	// Wait for Ctrl+C
	sig := make(chan os.Signal, 1)
	signal.Notify(sig, os.Interrupt, syscall.SIGTERM)
	<-sig

	fmt.Println("\nShutting down...")
	for _, cmd := range running {
		if cmd.Process != nil {
			cmd.Process.Signal(syscall.SIGTERM)
		}
	}

	// Give 5s for graceful shutdown
	done := make(chan struct{})
	go func() {
		wg.Wait()
		close(done)
	}()

	select {
	case <-done:
		fmt.Println("All services stopped.")
	case <-time.After(5 * time.Second):
		fmt.Println("Force killing remaining processes...")
		for _, cmd := range running {
			if cmd.Process != nil {
				cmd.Process.Kill()
			}
		}
	}
}

func cmdStatus() {
	fmt.Printf("%-14s %-8s %-6s %s\n", "SERVICE", "STATUS", "PORT", "LATENCY")
	fmt.Println(strings.Repeat("-", 50))

	client := &http.Client{Timeout: 500 * time.Millisecond}

	for _, svc := range allServices {
		url := fmt.Sprintf("http://localhost:%s/healthz", svc.Port)
		start := time.Now()
		resp, err := client.Get(url)
		latency := time.Since(start)

		status := "\033[31m● offline\033[0m"
		latStr := "-"
		if err == nil {
			resp.Body.Close()
			if resp.StatusCode == 200 {
				status = "\033[32m● healthy\033[0m"
				latStr = fmt.Sprintf("%dms", latency.Milliseconds())
			} else {
				status = "\033[33m● degraded\033[0m"
				latStr = fmt.Sprintf("%dms", latency.Milliseconds())
			}
		}

		fmt.Printf("%-14s %s  %-6s %s\n", svc.Name, status, svc.Port, latStr)
	}
}

func filterServices(names []string) []Service {
	nameSet := make(map[string]bool)
	for _, n := range names {
		nameSet[strings.ToLower(strings.TrimSpace(n))] = true
	}
	var result []Service
	for _, svc := range allServices {
		if nameSet[strings.ToLower(svc.Binary)] || nameSet[strings.ToLower(svc.Name)] {
			result = append(result, svc)
		}
	}
	return result
}

func getBinDir() string {
	exe, err := os.Executable()
	if err != nil {
		return "."
	}
	return filepath.Dir(exe)
}

func getExt() string {
	if os.PathSeparator == '\\' {
		return ".exe"
	}
	return ""
}

// Suppress unused import
var _ = json.Marshal
