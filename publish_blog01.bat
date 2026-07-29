@echo off
REM =============================================================
REM  Publish Blog 1: "The Liver Nobody Talks About, Until It's Too Late"
REM  Double-click to render the site and push it live to GitHub Pages.
REM =============================================================

cd /d "C:\Users\mailr\OneDrive\Documents\tumorscholar.github.io"
del /f ".git\index.lock" 2>nul

REM --- Warn if the two images are missing (post would show broken images) ---
set MISSING=0
if not exist "blog\blog_images\cover_liver_silent.png" (
  echo [WARNING] Missing blog\blog_images\cover_liver_silent.png  ^(cover/thumbnail^)
  set MISSING=1
)
if not exist "blog\blog_images\silent_progression.png" (
  echo [WARNING] Missing blog\blog_images\silent_progression.png  ^(inline figure^)
  set MISSING=1
)
if %MISSING%==1 (
  echo.
  echo One or more images are not in place yet. If you publish now, the post
  echo will go live with broken image links.
  echo.
  choice /M "Publish anyway"
  if errorlevel 2 (
    echo Cancelled. Add the PNGs to blog\blog_images and run this again.
    pause
    exit /b
  )
)

REM --- Render the whole site (regenerates the docs/ folder GitHub Pages serves) ---
echo.
echo Rendering site with Quarto...
quarto render
if errorlevel 1 (
  echo.
  echo [ERROR] quarto render failed. Fix the error above, then run this again.
  pause
  exit /b
)

REM --- Commit and push ---
git add -A
git status
git commit -m "Add Blog 1: The Liver Nobody Talks About, Until It's Too Late"
git push origin main

echo.
echo Done! The post should be live at https://tumorscholar.github.io/blog.html in a minute or two.
echo Press any key to close.
pause
