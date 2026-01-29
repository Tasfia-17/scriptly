#!/bin/bash

echo "🔍 Scriptly Fullstack Verification"
echo "=================================="

# Check Flutter app structure
echo "📱 Flutter App Structure:"
if [ -f "lib/main.dart" ]; then
    echo "✅ Main app entry point"
else
    echo "❌ Missing main.dart"
fi

if [ -d "lib/pages" ]; then
    page_count=$(ls lib/pages/*.dart 2>/dev/null | wc -l)
    echo "✅ Pages directory ($page_count pages)"
else
    echo "❌ Missing pages directory"
fi

if [ -d "lib/widgets" ]; then
    widget_count=$(ls lib/widgets/*.dart 2>/dev/null | wc -l)
    echo "✅ Widgets directory ($widget_count widgets)"
else
    echo "❌ Missing widgets directory"
fi

if [ -f "lib/services/serverpod_service.dart" ]; then
    echo "✅ Serverpod integration"
else
    echo "❌ Missing Serverpod service"
fi

# Check Serverpod backend
echo ""
echo "🖥️ Serverpod Backend:"
if [ -f "scriptly_server/bin/main.dart" ]; then
    echo "✅ Server entry point"
else
    echo "❌ Missing server main.dart"
fi

if [ -d "scriptly_server/lib/src/endpoints" ]; then
    endpoint_count=$(ls scriptly_server/lib/src/endpoints/*.dart 2>/dev/null | wc -l)
    echo "✅ API endpoints ($endpoint_count endpoints)"
else
    echo "❌ Missing endpoints directory"
fi

if [ -d "scriptly_server/lib/src/models" ]; then
    model_count=$(ls scriptly_server/lib/src/models/*.spy 2>/dev/null | wc -l)
    echo "✅ Data models ($model_count models)"
else
    echo "❌ Missing models directory"
fi

if [ -f "scriptly_server/config/development.yaml" ]; then
    echo "✅ Development configuration"
else
    echo "❌ Missing development config"
fi

# Check client package
echo ""
echo "📦 Client Package:"
if [ -f "scriptly_client/lib/scriptly_client.dart" ]; then
    echo "✅ Client library"
else
    echo "❌ Missing client library"
fi

# Check Docker setup
echo ""
echo "🐳 Docker Setup:"
if [ -f "docker-compose.yml" ]; then
    echo "✅ Docker Compose configuration"
else
    echo "❌ Missing Docker Compose"
fi

if [ -f "scriptly_server/Dockerfile" ]; then
    echo "✅ Server Dockerfile"
else
    echo "❌ Missing Server Dockerfile"
fi

# Check assets
echo ""
echo "🎨 Assets:"
if [ -d "assets/images" ]; then
    image_count=$(ls assets/images/*.{webp,png,jpg} 2>/dev/null | wc -l)
    echo "✅ Image assets ($image_count images)"
else
    echo "❌ Missing assets directory"
fi

# Check configuration files
echo ""
echo "⚙️ Configuration:"
if [ -f "pubspec.yaml" ]; then
    echo "✅ Flutter pubspec.yaml"
else
    echo "❌ Missing Flutter pubspec.yaml"
fi

if [ -f "scriptly_server/pubspec.yaml" ]; then
    echo "✅ Server pubspec.yaml"
else
    echo "❌ Missing Server pubspec.yaml"
fi

if [ -f "scriptly_client/pubspec.yaml" ]; then
    echo "✅ Client pubspec.yaml"
else
    echo "❌ Missing Client pubspec.yaml"
fi

echo ""
echo "🚀 Ready to run:"
echo "1. ./start_backend.sh (Start Serverpod backend)"
echo "2. flutter run (Start Flutter app)"
echo ""
echo "📊 Access points:"
echo "- API: http://localhost:8080"
echo "- Admin: http://localhost:8081"
echo "- Web: http://localhost:8082"
