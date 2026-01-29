# Scriptly Backend - Serverpod

Powerful Dart backend using Serverpod framework for the Scriptly storytelling app.

## Features

- **User Management**: Authentication and user profiles
- **Project Management**: Create and manage storytelling projects
- **Scene Management**: Organize story scenes with drag-and-drop reordering
- **Script Versioning**: Save and manage multiple script versions
- **AI Integration**: OpenAI GPT-4 for story generation and chat assistance
- **Real-time Chat**: AI-powered writing assistant
- **PostgreSQL Database**: Robust data persistence
- **Redis Caching**: High-performance caching layer

## Quick Start

### Prerequisites
- Docker and Docker Compose
- Dart SDK 3.0+
- OpenAI API key

### Development Setup

1. **Clone and setup**:
```bash
# Backend is already created in scriptly_server/
cd scriptly_server
```

2. **Configure environment**:
```bash
# Edit config/development.yaml
# Add your OpenAI API key
```

3. **Start services**:
```bash
# From project root
./start_backend.sh
```

4. **Access endpoints**:
- API: http://localhost:8080
- Insights Dashboard: http://localhost:8081
- Web Interface: http://localhost:8082

## API Endpoints

### Projects
- `GET /project/getUserProjects/{userId}` - Get user projects
- `POST /project/createProject` - Create new project
- `PUT /project/updateProject` - Update project
- `DELETE /project/deleteProject/{id}` - Delete project

### Scenes
- `GET /scene/getProjectScenes/{projectId}` - Get project scenes
- `POST /scene/createScene` - Create scene
- `PUT /scene/updateScene` - Update scene
- `POST /scene/reorderScenes` - Reorder scenes

### Scripts
- `GET /script/getProjectScripts/{projectId}` - Get project scripts
- `POST /script/saveScript` - Save script version
- `GET /script/getLatestScript/{projectId}` - Get latest script

### AI Services
- `POST /ai/generateOutline` - Generate story outline
- `POST /ai/generateScript` - Generate screenplay
- `POST /ai/chatAssistant` - Chat with AI assistant

## Database Schema

### Users
- id, email, name, createdAt
- One-to-many with Projects

### Projects  
- id, title, description, userId, createdAt, updatedAt
- One-to-many with Scenes and Scripts

### Scenes
- id, title, content, duration, locked, projectId, order, createdAt

### Scripts
- id, content, version, projectId, createdAt

### ChatMessages
- id, role, content, userId, createdAt

## Production Deployment

### Using Docker Compose
```bash
# Set environment variables
export OPENAI_API_KEY=your_key_here

# Deploy
docker-compose up -d
```

### Environment Variables
- `DATABASE_HOST` - PostgreSQL host
- `DATABASE_USER` - Database user
- `DATABASE_PASSWORD` - Database password
- `OPENAI_API_KEY` - OpenAI API key
- `REDIS_HOST` - Redis host

## Flutter Integration

The backend integrates seamlessly with the Flutter frontend:

```dart
// Initialize client
ScriptlyClient.initialize(serverUrl: 'http://localhost:8080/');

// Use services
final projects = await ScriptlyClient.getUserProjects(userId);
final outline = await ScriptlyClient.generateOutline(idea);
```

## Development Commands

```bash
# Generate Serverpod code
serverpod generate

# Run migrations
serverpod create-migration

# Start server
dart run bin/main.dart

# Run tests
dart test
```
