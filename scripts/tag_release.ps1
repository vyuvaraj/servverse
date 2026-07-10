# PowerShell script to create and push release tag v0.2.0 for modified repositories

$repos = @(
    "ServCloud",
    "ServPool",
    "ServMail",
    "ServFlow",
    "ServDocs",
    "ServCache",
    "servverse-repo"
)

$tag = "v0.2.0"
$message = "Release v0.2.0"

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "Tagging and pushing release $tag to origin..." -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

foreach ($repo in $repos) {
    # Check if folder exists
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
            # Delete tag locally and remotely if it somehow exists (idempotency)
            git tag -d $tag 2>$null
            git push --delete origin $tag 2>$null

            # Tag and push
            git tag -a $tag -m $message
            git push origin $tag
            Write-Host "✅ Successfully tagged and pushed $repo as $tag" -ForegroundColor Green
        } catch {
            Write-Host "❌ Failed to tag/push $repo" -ForegroundColor Red
        }
        Pop-Location
        Write-Host ""
    }
}

Write-Host "Release tagging complete!" -ForegroundColor Green
