# PowerShell script to synchronize all dependent modules when ServShared is updated.
#
# It automatically:
# 1. Resolves the latest local commit hash of ServShared.
# 2. Upgrades the dependency version to that commit in each dependent module.
# 3. Removes any local replacement directives from go.mod (to prevent runner errors).
# 4. Tidies dependencies and re-vendors files.
# 5. Runs a build validation check.
# 6. Commits and pushes the updates.

param(
    [switch]$SkipCommit,
    [switch]$SkipPush
)

# Resolve parent directory containing all repositories
$parentDir = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$sharedDir = Join-Path $parentDir "ServShared"

if (-not (Test-Path $sharedDir)) {
    Write-Error "ServShared directory not found next to servverse-repo!"
    exit 1
}

# Resolve latest ServShared commit hash
Push-Location $sharedDir
$latestCommit = git log -n 1 --pretty=format:"%H"
Pop-Location

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "Synchronizing ServShared dependent modules..." -ForegroundColor Cyan
Write-Host "Latest ServShared Commit: $latestCommit" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

$repos = Get-ChildItem -Path $parentDir -Directory
$env:GOWORK = "off"

foreach ($repo in $repos) {
    $repoName = $repo.Name
    if ($repoName -eq "ServShared" -or $repoName -eq "ServDocs" -or $repoName -eq "servverse-repo") {
        continue
    }

    $goModPath = Join-Path $repo.FullName "go.mod"
    if (Test-Path $goModPath) {
        $content = Get-Content $goModPath -Raw
        if ($content -match "github.com/vyuvaraj/ServShared") {
            Write-Host "Processing dependent module: ${repoName}..." -ForegroundColor Yellow
            
            Push-Location $repo.FullName
            try {
                # 1. Remove replace directive if it exists
                if ($content -match "replace github.com/vyuvaraj/ServShared") {
                    Write-Host "  -> Removing replace directive from go.mod"
                    # Filter out any lines matching the replace pattern
                    $lines = Get-Content "go.mod" | Where-Object { $_ -notmatch "replace github.com/vyuvaraj/ServShared" }
                    Set-Content "go.mod" $lines
                }

                # 2. Get the latest commit of ServShared
                Write-Host "  -> Upgrading ServShared dependency reference..."
                go get "github.com/vyuvaraj/ServShared@$latestCommit"

                # 3. Tidy dependencies
                Write-Host "  -> Tidying dependencies..."
                go mod tidy

                # 4. Sync vendor folder if it exists
                $vendorPath = Join-Path $repo.FullName "vendor"
                if (Test-Path $vendorPath) {
                    Write-Host "  -> Syncing vendor directory..."
                    go mod vendor
                }

                # 5. Compile check
                Write-Host "  -> Verifying build sanity..."
                go build ./...
                if ($LASTEXITCODE -ne 0) {
                    Write-Host "  ❌ Sanity check failed for ${repoName}" -ForegroundColor Red
                    Pop-Location
                    continue
                }

                # 6. Commit and push if changed
                $gitStatus = git status --porcelain
                if ($gitStatus) {
                    if (-not $SkipCommit) {
                        Write-Host "  -> Committing updates..." -ForegroundColor Gray
                        if (Test-Path "vendor") {
                            git add --force vendor
                        }
                        git add -A
                        git commit -m "readiness: upgrade dependency reference and vendor for ServShared commit $latestCommit"
                        
                        if (-not $SkipPush) {
                            Write-Host "  -> Pushing changes to origin main..." -ForegroundColor Gray
                            git push origin main
                        }
                    }
                    Write-Host "  ✅ Successfully synchronized ${repoName}" -ForegroundColor Green
                } else {
                    Write-Host "  ✅ No changes detected for ${repoName}" -ForegroundColor Green
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
