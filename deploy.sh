#!/bin/bash
# DevSeniorCode Meet - Deployment Script
# Compiles locally and prepares for Docker deployment

set -e

echo "🔨 DevSeniorCode Meet - Local Build & Deploy"
echo "==========================================="
echo ""

# Check if make is available
if ! command -v make &> /dev/null; then
    echo "❌ Error: 'make' command not found"
    echo "   Install Make for Windows: https://gnuwin32.sourceforge.net/packages/make.htm"
    echo "   Or use WSL/Linux"
    exit 1
fi

# Step 1: Clean previous builds
echo "🧹 Cleaning previous builds..."
make clean
echo ""

# Step 2: Compile JavaScript bundles
echo "📦 Compiling JavaScript bundles..."
make compile
echo ""

# Step 3: Deploy to libs/
echo "🚚 Deploying to libs/..."
make deploy
echo ""

# Step 4: Compile CSS (if needed)
if [ ! -f "css/all.css" ]; then
    echo "🎨 Compiling CSS..."
    npx sass css/main.scss css/all.bundle.css
    ./node_modules/.bin/cleancss --skip-rebase css/all.bundle.css -o css/all.css
    echo ""
fi

# Step 5: Verify required files exist
echo "✅ Verifying build artifacts..."
required_files=(
    "libs/app.bundle.min.js"
    "libs/external_api.min.js"
    "css/all.css"
    "index.html"
    "interface_config.js"
)

all_good=true
for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✓ $file"
    else
        echo "  ❌ $file (missing)"
        all_good=false
    fi
done

echo ""

if [ "$all_good" = true ]; then
    echo "✅ Build successful!"
    echo ""
    echo "📦 Ready to deploy:"
    echo "   1. Commit changes: git add . && git commit -m 'chore: update production build'"
    echo "   2. Push to GitHub: git push origin master"
    echo "   3. Dokploy will build container in ~2-5 minutes (not 30-60 minutes!)"
    echo ""
    echo "🚀 Deployment time: ~2-5 minutes (vs 30-60 min with old Dockerfile)"
else
    echo "❌ Build failed - some files are missing"
    exit 1
fi
