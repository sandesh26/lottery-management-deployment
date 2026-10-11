#!/bin/bash
# ==============================================================================
# GameXpro Lottery Management System - Target Server Deployment Script
# Runs on the target host/server to deploy, configure, migrate, and start the app
# ==============================================================================
set -e

# Default settings
ZIP_FILE="${1:-lottery-management.zip}"
DEPLOY_DIR="${2:-.}"
PORT="${PORT:-5001}"

echo "=========================================================="
echo "🚀 GameXpro Lottery Management - Deployment Runner"
echo "=========================================================="

# 1. If an archive file is specified and exists, unpack it into DEPLOY_DIR
if [ -f "$ZIP_FILE" ]; then
  echo "📦 Extracting package: $ZIP_FILE into $DEPLOY_DIR..."
  mkdir -p "$DEPLOY_DIR"
  
  # Preserve existing .env if present before unzipping
  if [ -f "$DEPLOY_DIR/.env" ]; then
    echo "🔒 Backing up existing production .env file..."
    cp "$DEPLOY_DIR/.env" "$DEPLOY_DIR/.env.backup.$(date +%Y%m%d%H%M%S)"
    HAS_EXISTING_ENV=true
  else
    HAS_EXISTING_ENV=false
  fi

  unzip -q -o "$ZIP_FILE" -d "$DEPLOY_DIR"

  # Restore user's customized .env if it was backed up
  if [ "$HAS_EXISTING_ENV" = true ]; then
    echo "🔒 Restoring existing production .env file..."
    cp "$DEPLOY_DIR/.env.backup."* "$DEPLOY_DIR/.env" 2>/dev/null || true
  fi

  cd "$DEPLOY_DIR"
fi

# 2. Check Node.js and NPM availability
if ! command -v node &> /dev/null; then
  echo "❌ Error: Node.js is not installed or not in PATH."
  echo "Please install Node.js 18.x or 20.x before deploying."
  exit 1
fi

echo "🟢 Node.js version: $(node -v)"
echo "🟢 NPM version:     $(npm -v)"

# 3. Environment configuration validation
if [ ! -f ".env" ]; then
  if [ -f ".env.example" ]; then
    echo "⚠️  No .env found. Creating .env from .env.example..."
    cp .env.example .env
  else
    echo "⚠️  Creating default .env template..."
    cat << 'EOF' > .env
NODE_ENV=production
PORT=5001
DATABASE_URL="mysql://root:@localhost:3306/LotteryManagement"
VITE_API_BASE_URL="http://localhost:5001"
EOF
  fi
  echo "⚠️  Please check and configure database credentials in .env!"
fi

# 4. Install production dependencies
echo "📦 Installing production dependencies (npm install --omit=dev)..."
npm install --omit=dev --no-audit --no-fund

# 5. Generate Prisma Client for the host machine OS & architecture
echo "🗄️  Generating Prisma Client..."
npx prisma generate

# 6. Synchronize database schema with MySQL
echo "🗄️  Applying database schema migrations (prisma db push)..."
npx prisma db push --skip-generate || {
  echo "⚠️  Warning: prisma db push encountered an issue. Ensure MySQL is running."
}

# 7. Start or restart the services
echo "=========================================================="
echo "✨ Deployment successful!"
echo "🌐 Frontend Web App:    http://localhost:${FRONTEND_PORT:-3005}/"
echo "📡 Backend API Server:  http://localhost:${PORT:-5001}/"
echo "🩺 API Health Check:    http://localhost:${PORT:-5001}/api/health"
echo "📱 Android APK:         http://localhost:${PORT:-5001}/download/apk"
echo "=========================================================="

# Check if PM2 is available for production process supervision
if command -v pm2 &> /dev/null; then
  echo "🔄 Starting / restarting application via PM2 process manager..."
  if [ -f "ecosystem.config.cjs" ]; then
    pm2 restart ecosystem.config.cjs 2>/dev/null || pm2 start ecosystem.config.cjs
  else
    pm2 restart lottery-backend 2>/dev/null || pm2 start server.js --name "lottery-backend"
    if [ -f "frontend-server.js" ]; then
      pm2 restart lottery-frontend 2>/dev/null || pm2 start frontend-server.js --name "lottery-frontend"
    fi
  fi
  pm2 save
  echo "✅ Services running under PM2:"
  echo "   - lottery-backend   (Port ${PORT:-5001})"
  echo "   - lottery-frontend  (Port ${FRONTEND_PORT:-3005})"
  echo "Run 'pm2 list' or 'pm2 logs' to view status."
else
  echo "▶️  PM2 not found. Starting server in foreground via Node.js..."
  echo "💡 Tip: Install PM2 (npm install -g pm2) for automatic restarts and separate process management."
  exec node server.js
fi
