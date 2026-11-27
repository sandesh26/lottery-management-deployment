@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo ==========================================================
echo GameXpro Lottery Management - Windows PM2 Startup Runner
echo ==========================================================

:: 1. Check Node.js availability
where node >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Node.js is not installed or not in PATH.
  echo Please install Node.js 18.x or 20.x before running this script.
  pause
  exit /b 1
)

for /f "delims=" %%v in ('node -v') do set "NODE_VER=%%v"
echo Node.js version: %NODE_VER%

:: 2. Check PM2 availability
where pm2 >nul 2>&1
if errorlevel 1 (
  echo [ERROR] PM2 is not installed or not in PATH.
  echo Install PM2 globally with: npm install -g pm2
  pause
  exit /b 1
)

:: 3. Ensure logs directory exists for ecosystem.config.cjs
if not exist "logs" (
  mkdir "logs"
)

:: 4. Ensure .env exists
if not exist ".env" (
  if exist ".env.example" (
    echo [WARN] No .env found. Creating .env from .env.example...
    copy /Y ".env.example" ".env" >nul
  ) else (
    echo [WARN] No .env file found. Please create and configure .env before starting in production.
  )
)

:: 5. Install production dependencies if node_modules is missing
if not exist "node_modules" (
  echo Installing production dependencies ^(npm install --omit=dev^)...
  call npm install --omit=dev --no-audit --no-fund
  if errorlevel 1 (
    echo [ERROR] npm install failed.
    pause
    exit /b 1
  )
)

:: 6. Start or restart services via PM2
echo Starting / restarting services via PM2...
if exist "ecosystem.config.cjs" (
  call pm2 restart ecosystem.config.cjs >nul 2>&1
  if errorlevel 1 (
    call pm2 start ecosystem.config.cjs
  )
) else (
  call pm2 restart lottery-backend >nul 2>&1
  if errorlevel 1 (
    call pm2 start server.js --name "lottery-backend"
  )
  if exist "frontend-server.js" (
    call pm2 restart lottery-frontend >nul 2>&1
    if errorlevel 1 (
      call pm2 start frontend-server.js --name "lottery-frontend"
    )
  )
)

if errorlevel 1 (
  echo [ERROR] Failed to start PM2 services.
  pause
  exit /b 1
)

:: 7. Save PM2 process list and display status
call pm2 save
echo.
echo ==========================================================
echo Services running under PM2:
echo   Frontend Web App:    http://localhost:3005/
echo   Backend API Server:  http://localhost:5001/
echo   API Health Check:    http://localhost:5001/api/health
echo   Android APK:         http://localhost:5001/download/apk
echo ==========================================================
call pm2 list
echo.
echo Run "pm2 logs" to stream live server logs.
pause
