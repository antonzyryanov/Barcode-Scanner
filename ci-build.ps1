# Barcode Scanner CI Script with Build
# Runs tests, builds the project, and pushes to git if everything passes

param(
    [string]$CommitMessage = "CI: Automated commit after passing tests and build"
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Barcode Scanner CI Pipeline (with Build)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Step 1: Run tests
Write-Host "`n[1/4] Running Flutter tests..." -ForegroundColor Yellow
flutter test

if ($LASTEXITCODE -ne 0) {
    Write-Host "`n[FAILED] Tests did not pass. Aborting CI pipeline." -ForegroundColor Red
    exit 1
}

Write-Host "`n[SUCCESS] All tests passed!" -ForegroundColor Green

# Step 2: Build the project
Write-Host "`n[2/4] Building Flutter project..." -ForegroundColor Yellow
flutter build apk --release

if ($LASTEXITCODE -ne 0) {
    Write-Host "`n[FAILED] Build failed. Aborting CI pipeline." -ForegroundColor Red
    exit 1
}

Write-Host "`n[SUCCESS] Build completed successfully!" -ForegroundColor Green

# Step 3: Check for uncommitted changes
Write-Host "`n[3/4] Checking for changes..." -ForegroundColor Yellow
$status = git status --porcelain
if ([string]::IsNullOrWhiteSpace($status)) {
    Write-Host "No changes to commit." -ForegroundColor Gray
    exit 0
}

# Step 4: Commit and push
Write-Host "`n[4/4] Committing and pushing to git..." -ForegroundColor Yellow
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