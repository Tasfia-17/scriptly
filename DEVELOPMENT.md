# Scriptly Development Guide

## Quick Start Commands

```bash
# 1. Verify setup
./verify_setup.sh

# 2. Start backend services
./start_backend.sh

# 3. Run Flutter app (in new terminal)
flutter pub get
flutter run
```

## Development Workflow

### Backend Development
```bash
# Navigate to server
cd scriptly_server

# Generate Serverpod code (if CLI available)
serverpod generate

# Run server directly
dart run bin/main.dart

# Run tests
dart test
```

### Frontend Development
```bash
# Install dependencies
flutter pub get

# Run on device/emulator
flutter run

# Run tests
flutter test

# Build for release
flutter build apk --release
```

### Database Operations
```bash
# Start database only
docker-compose up -d postgres

# View database logs
docker-compose logs postgres

# Connect to database
docker exec -it scriptly_postgres_1 psql -U postgres -d scriptly_dev
```

## API Endpoints

### Projects
- `POST /project/createProject` - Create new project
- `GET /project/getUserProjects/{userId}` - Get user projects
- `PUT /project/updateProject` - Update project
- `DELETE /project/deleteProject/{id}` - Delete project

### Scenes
- `GET /scene/getProjectScenes/{projectId}` - Get project scenes
- `POST /scene/createScene` - Create scene
- `PUT /scene/updateScene` - Update scene
- `POST /scene/reorderScenes` - Reorder scenes

### AI Services
- `POST /ai/generateOutline` - Generate story outline
- `POST /ai/generateScript` - Generate screenplay
- `POST /ai/chatAssistant` - Chat with AI

## Environment Setup

### Required Environment Variables
```bash
# Development (in scriptly_server/config/development.yaml)
passwords:
  openai_api_key: 'your-openai-key-here'

# Production
export OPENAI_API_KEY=your_key_here
export DATABASE_URL=postgresql://user:pass@host:5432/db
export REDIS_URL=redis://host:6379
```

### Docker Services
```bash
# Start all services
docker-compose up -d

# Start specific service
docker-compose up -d postgres
docker-compose up -d redis

# View logs
docker-compose logs -f scriptly_server

# Stop all services
docker-compose down
```

## Troubleshooting

### Common Issues

1. **Port conflicts**
   ```bash
   # Check what's using ports
   lsof -i :8080
   lsof -i :5432
   ```

2. **Database connection issues**
   ```bash
   # Reset database
   docker-compose down
   docker volume rm scriptly_postgres_data
   docker-compose up -d postgres
   ```

3. **Flutter build issues**
   ```bash
   # Clean and rebuild
   flutter clean
   flutter pub get
   flutter run
   ```

4. **Serverpod code generation**
   ```bash
   # If serverpod CLI not available, models are pre-created
   # Manual generation would require:
   # dart pub global activate serverpod_cli
   # serverpod generate
   ```

## Project Structure Overview

```
scriptly/
├── 📱 Flutter App (lib/)
│   ├── pages/          # 10 app screens
│   ├── widgets/        # 4 reusable components  
│   ├── services/       # Serverpod integration
│   └── openai/         # AI client
├── 🖥️ Serverpod Backend (scriptly_server/)
│   ├── endpoints/      # 5 API endpoints
│   ├── models/         # 5 data models
│   └── config/         # Environment configs
├── 📦 Client Package (scriptly_client/)
│   └── lib/            # Shared client code
└── 🐳 Docker Setup
    ├── docker-compose.yml
    └── Dockerfile
```

## Testing

### Backend Tests
```bash
cd scriptly_server
dart test
```

### Frontend Tests
```bash
flutter test
```

### Integration Tests
```bash
# Start backend first
./start_backend.sh

# Run Flutter integration tests
flutter test integration_test/
```

## Deployment

### Development
```bash
./start_backend.sh
flutter run
```

### Production
```bash
# Set environment variables
export OPENAI_API_KEY=your_key

# Deploy backend
docker-compose -f docker-compose.prod.yml up -d

# Build Flutter app
flutter build apk --release
```
