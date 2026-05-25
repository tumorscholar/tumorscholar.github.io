@echo off
cd /d "%~dp0"
echo Committing spacing fix...
git add styles.css docs/styles.css
git commit -m "Tighten blog post spacing (18px padding)"
echo Pushing to GitHub...
git push origin main
echo.
echo Done! Press any key to close.
pause
