# PowerShell script to push all Serv ecosystem repositories to origin main

$repos = @(
    "Serv-lang",
    "ServGate",
    "ServStore",
    "ServQueue",
    "ServConsole",
    "ServCache",
    "ServMesh",
    "ServCron",
    "ServCloud",
    "ServTrace",
    "ServTunnel",
    "ServAuth",
    "ServPool",
    "ServMail",
    "ServFlow",
    "ServRegistry",
    "ServShared",
    "ServDocs",
    "servverse-repo"
)

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "Pushing all Serv ecosystem repositories to origin..." -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

foreach ($repo in $repos) {
    # Check if the folder exists in parent or current dir
    $repoPath = Join-Path ".." $repo
    if (-not (Test-Path $repoPath)) {
        $repoPath = Join-Path "." $repo
        if (-not (Test-Path $repoPath)) {
            continue
        }
    }

    $gitPath = Join-Path $repoPath ".git"
    if (Test-Path $gitPath) {
        Write-Host "Processing repository: $repo..." -ForegroundColor Yellow
        Push-Location $repoPath
        try {
            # Execute git push origin main
            git push origin main
            Write-Host "✅ Successfully processed $repo" -ForegroundColor Green
        } catch {
            Write-Host "❌ Failed to push $repo" -ForegroundColor Red
        }
        Pop-Location
        Write-Host ""
    }
}

Write-Host "Done pushing all repositories!" -ForegroundColor Green
