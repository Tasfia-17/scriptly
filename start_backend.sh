#!/bin/bash

echo "🚀 Starting Scriptly Backend Development Environment"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Start database services
echo "📦 Starting PostgreSQL and Redis..."
docker-compose up -d postgres redis

# Wait for database to be ready
echo "⏳ Waiting for database to be ready..."
sleep 5

# Generate Serverpod code (if CLI is available)
if command -v serverpod &> /dev/null; then
    echo "🔧 Generating Serverpod code..."
    cd scriptly_server
    serverpod generate
    cd ..
fi

# Start the server
echo "🖥️  Starting Serverpod server..."
cd scriptly_server
dart run bin/main.dart

echo "✅ Scriptly backend is running!"
echo "📊 API: http://localhost:8080"
echo "📈 Insights: http://localhost:8081" 
echo "🌐 Web: http://localhost:8082"
