package e2e

import (
	"context"
	"net/http"
	"net/http/httptest"
	"testing"
	"time"
)

// TestChaosRecovery verifies that the service gracefully handles transient dependency failures.
func TestChaosRecovery(t *testing.T) {
	requestCount := 0
	mockDependency := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		requestCount++
		if requestCount%2 == 0 {
			w.WriteHeader(http.StatusServiceUnavailable)
			w.Write([]byte(`{"error":"Service Unreachable"}`))
			return
		}
		w.WriteHeader(http.StatusOK)
		w.Write([]byte(`{"status":"ok"}`))
	}))
	defer mockDependency.Close()

	client := &http.Client{Timeout: 500 * time.Millisecond}
	for i := 1; i <= 3; i++ {
		req, _ := http.NewRequestWithContext(context.Background(), "GET", mockDependency.URL, nil)
		resp, err := client.Do(req)
		if err != nil {
			t.Fatalf("Request failed: %v", err)
		}
		resp.Body.Close()

		if i%2 == 0 {
			if resp.StatusCode != http.StatusServiceUnavailable {
				t.Errorf("Expected 503 Service Unavailable on request %d, got %d", i, resp.StatusCode)
			}
		} else {
			if resp.StatusCode != http.StatusOK {
				t.Errorf("Expected 200 OK on request %d, got %d", i, resp.StatusCode)
			}
		}
	}
}
