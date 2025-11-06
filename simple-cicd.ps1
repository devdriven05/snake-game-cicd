# Simple CI/CD Pipeline for Snake Game
Write-Host "🐍 Starting Snake Game CI/CD Pipeline..." -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan

# Step 1: Install dependencies
Write-Host "`n[1/4] Installing dependencies..." -ForegroundColor Yellow
pip install -r requirements.txt
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to install dependencies" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Dependencies installed" -ForegroundColor Green

# Step 2: Run tests
Write-Host "`n[2/4] Running tests..." -ForegroundColor Yellow
python -m pytest tests/ -v
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Tests failed" -ForegroundColor Red
    exit 1
}
Write-Host "✅ All tests passed" -ForegroundColor Green

# Step 3: Build executable
Write-Host "`n[3/4] Building executable..." -ForegroundColor Yellow
pip install pyinstaller
pyinstaller --onefile --name snake-game main.py
if (Test-Path "dist/snake-game.exe") {
    $size = (Get-Item "dist/snake-game.exe").Length
    Write-Host "✅ Executable built: dist/snake-game.exe ($([math]::Round($size/1MB, 2)) MB)" -ForegroundColor Green
} else {
    Write-Host "❌ Build failed" -ForegroundColor Red
    exit 1
}

# Step 4: Generate report
Write-Host "`n[4/4] Generating report..." -ForegroundColor Yellow
@"
# Snake Game CI/CD Report
Generated: $(Get-Date)

## Results
- ✅ Dependencies: Installed
- ✅ Tests: Passed
- ✅ Build: Successful
- 🎮 Game: Ready to play!

## How to Play
1. Run: python main.py
2. Or: .\dist\snake-game.exe

## Controls
- Arrow Keys: Move snake
- ESC: Quit game
- R: Restart after game over

## Files Created
- main.py (Game source)
- dist/snake-game.exe (Windows executable)
- tests/ (Unit tests)

Enjoy your game! 🐍
"@ | Out-File -FilePath "CICD_REPORT.md" -Encoding utf8
Write-Host "✅ Report generated: CICD_REPORT.md" -ForegroundColor Green

# Final message
Write-Host "`n" + "="*50 -ForegroundColor Green
Write-Host "🎉 CI/CD PIPELINE COMPLETED SUCCESSFULLY!" -ForegroundColor Green
Write-Host "="*50 -ForegroundColor Green

Write-Host "`n🚀 Quick Start:" -ForegroundColor Cyan
Write-Host "   Play game: python main.py" -ForegroundColor White
Write-Host "   Run executable: .\dist\snake-game.exe" -ForegroundColor White
Write-Host "   View report: .\CICD_REPORT.md" -ForegroundColor White

Write-Host "`n🐍 Your Snake Game is ready! Run: python main.py" -ForegroundColor Magenta
