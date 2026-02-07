# Barcode Scanner CI Script
# Runs tests and pushes to git if they pass

param(
    [string]$CommitMessage = "CI: Automated commit after passing tests"
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Barcode Scanner CI Pipeline" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Step 1: Run tests
Write-Host "`n[1/3] Running Flutter tests..." -ForegroundColor Yellow
flutter test

if ($LASTEXITCODE -ne 0) {
    Write-Host "`n[FAILED] Tests did not pass. Aborting CI pipeline." -ForegroundColor Red
    exit 1
}

Write-Host "`n[SUCCESS] All tests passed!" -ForegroundColor Green

# Step 2: Check for uncommitted changes
Write-Host "`n[2/3] Checking for changes..." -ForegroundColor Yellow
$status = git status --porcelain
if ([string]::IsNullOrWhiteSpace($status)) {
    Write-Host "No changes to commit." -ForegroundColor Gray
    exit 0
}

# Step 3: Commit and push
Write-Host "`n[3/3] Committing and pushing to git..." -ForegroundColor Yellow
git add -A
git commit -m $CommitMessage
if ($LASTEXITCODE -ne 0) {
    Write-Host "[WARNING] Commit failed. Changes may already be committed." -ForegroundColor Yellow
    exit 0
}

git push
if ($LASTEXITCODE -ne 0) {
    Write-Host "[FAILED] Git push failed." -ForegroundColor Red
    exit 1
}

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "CI Pipeline completed successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
