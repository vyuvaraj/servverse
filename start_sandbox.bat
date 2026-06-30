@echo off
title Servverse Sandbox Control Plane
cls
echo ==========================================================
echo       SERVVERSE ECOSYSTEM SANDBOX QUICKSTART
echo ==========================================================
echo.

:: Check for Podman
where podman >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Podman is required but not installed or not in PATH.
    pause
    exit /b 1
)

echo [INFO] Podman detected successfully.
echo [INFO] Spinning up ecosystem services via Podman Compose...
echo.

:: Launch podman compose stack
podman compose up -d --build
if %errorlevel% neq 0 (
    echo [ERROR] Failed to start container stack via podman compose.
    pause
    exit /b 1
)

echo.
echo ==========================================================
echo       SANDBOX SERVICES ONLINE
echo ==========================================================
echo  * ServConsole Dashboard : http://localhost:8083
echo  * ServGate API Gateway  : http://localhost:8080
echo  * ServRegistry Package  : http://localhost:8088
echo  * ServTrace Engine      : http://localhost:8090
echo ==========================================================
echo.
echo [INFO] Launching automated workload generator to simulate live traffic...
echo [INFO] Press Ctrl+C in this terminal window to stop the generator.
echo.

cd scripts
go run load_generator.go
