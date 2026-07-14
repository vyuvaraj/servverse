# PowerShell script to synchronize all dependent modules when ServShared is updated.
#
# It automatically:
# 1. Adds the local replace directive in go.mod for ServShared.
# 2. Re-vendors the dependency if the module uses vendoring.
# 3. Runs a sanity compilation check.
# 4. Commits and pushes the updates to origin main.

param(
    [switch]$SkipCommit,
    [switch]$SkipPush
)

# Resolve parent directory containing all repositories
$parentDir = Resolve-Path (Join-Path $PSScriptRoot "..")
$repos = Get-ChildItem -Path $parentDir -Directory

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "Synchronizing ServShared dependent modules..." -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

$env:GOWORK = "off"

foreach ($repo in $repos) {
    $repoName = $repo.Name
    if ($repoName -eq "ServShared") {
        continue
    }

    $goModPath = Join-Path $repo.FullName "go.mod"
    if (Test-Path $goModPath) {
        # Check if this module requires ServShared
        $content = Get-Content $goModPath -Raw
        if ($content -match "github.com/vyuvaraj/ServShared") {
            Write-Host "Processing dependent module: $repoName..." -ForegroundColor Yellow
            
            # 1. Ensure replace directive exists in go.mod
            if ($content -notmatch "replace github.com/vyuvaraj/ServShared") {
                Write-Host "  -> Adding local replace directive to go.mod"
                $replaceLine = "`r`nreplace github.com/vyuvaraj/ServShared => ../ServShared`r`n"
                $content = $content.Trim() + $replaceLine
                Set-Content $goModPath $content -NoNewline
            }

            Push-Location $repo.FullName
            try {
                # 2. Sync vendor folder if it exists
                $vendorPath = Join-Path $repo.FullName "vendor"
                if (Test-Path $vendorPath) {
                    Write-Host "  -> Syncing vendor directory..."
                    go mod vendor
                }

                # 3. Compile check
                Write-Host "  -> Verifying build sanity..."
                go build ./...
                if ($LASTEXITCODE -ne 0) {
                    Write-Host "  ❌ Sanity check failed for $repoName" -ForegroundColor Red
                    Pop-Location
                    continue
                }

                # 4. Commit and push if changed
                $gitStatus = git status --porcelain
                if ($gitStatus) {
                    if (-not $SkipCommit) {
                        Write-Host "  -> Committing updates..." -ForegroundColor Gray
                        git add -A
                        git commit -m "readiness: sync local replace directive and vendor directory for ServShared"
                        
                        if (-not $SkipPush) {
                            Write-Host "  -> Pushing changes to origin main..." -ForegroundColor Gray
                            git push origin main
                        }
                    }
                    Write-Host "  ✅ Successfully synchronized $repoName" -ForegroundColor Green
                } else {
                    Write-Host "  ✅ No changes detected for $repoName" -ForegroundColor Green
                }
            } catch {
                Write-Host "  ❌ Failed to process ${repoName}: $($_.Exception.Message)" -ForegroundColor Red
            }
            Pop-Location
            Write-Host ""
        }
    }
}

Remove-Item env:GOWORK
Write-Host "Synchronization process complete!" -ForegroundColor Green
