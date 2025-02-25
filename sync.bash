@echo off
setlocal

:: Set your project directory and GitHub repo URL
set "PROJECT_DIR=C:\Users\ChukwukaEgbuchunam\Documents\test"
set "GIT_REPO=https://github.com/chuks-egbuchunam/test.git"
set "BRANCH=main"

:: Navigate to project directory
cd /d "%PROJECT_DIR%"

:: Check if Git is installed
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo Git is not installed. Please install Git first.
    exit /b 1
)

:: Initialize Git if not already initialized
if not exist ".git" (
    echo Initializing Git repository...
    git init
    git remote add origin %GIT_REPO%
)

:: Ensure correct remote URL is set
git remote set-url origin %GIT_REPO%

:: Pull latest changes from GitHub
echo Pulling latest changes from GitHub...
git pull origin %BRANCH% --rebase

:: Add and commit all changes
echo Staging and committing changes...
git add .
git commit -m "Syncing local changes with GitHub"

:: Push changes to GitHub
echo Pushing changes to GitHub...
git push -u origin %BRANCH%

echo Sync completed successfully!

:: Pause to view results
pause
