@echo off
setlocal

:: Set Variables
set "GITHUB_USER=chuks-egbuchunam"
set "GITHUB_EMAIL=chuks.egbuchunam@playershealth.com"
set "GITHUB_TOKEN=%GITHUB_TOKEN%"
set "PROJECT_DIR=C:\Users\ChukwukaEgbuchunam\Documents\test"
set "REPO_NAME=test"
set "GITHUB_API=https://api.github.com/user/repos"
set "GIT_REPO=https://github.com/%GITHUB_USER%/%REPO_NAME%.git"

:: Navigate to project directory
cd /d "%PROJECT_DIR%"

:: Check if Git is installed
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo Git is not installed. Please install Git first.
    exit /b 1
)

:: Check if the repository already exists on GitHub
curl -H "Authorization: token %GITHUB_TOKEN%" -s %GITHUB_API% | findstr /C:"%REPO_NAME%" >nul
if %errorlevel% neq 0 (
    echo Creating a new repository on GitHub...
    curl -H "Authorization: token %GITHUB_TOKEN%" ^
         -H "Accept: application/vnd.github.v3+json" ^
         --request POST ^
         --data "{\"name\":\"%REPO_NAME%\", \"private\":false}" ^
         %GITHUB_API%
    echo Repository created successfully.
)

:: Initialize Git if not already initialized
if not exist ".git" (
    git init
)

:: Set up GitHub remote
git remote set-url origin %GIT_REPO% 2>nul || git remote add origin %GIT_REPO%

:: Create and switch to main branch
git branch -M main

:: Pull latest changes from GitHub (if any)
git pull origin main --rebase 2>nul

:: Add and commit all changes
git add .
git commit -m "Syncing test folder with GitHub"

:: Push changes
git push -u origin main

echo Successfully pushed %PROJECT_DIR% to %GIT_REPO%
pause
