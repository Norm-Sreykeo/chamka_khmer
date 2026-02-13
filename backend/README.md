# Dart Backend API

A simple REST API built with Dart and Shelf framework for testing with Postman.

## 🚀 Getting Started

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Start the Server
```bash
dart run backend/bin/server.dart
```

The server will start on `http://localhost:8080`

## 📡 API Endpoints

### Test Endpoint
- **GET** `/api/test` - Test server connection

### Users API
- **GET** `/api/users` - Get all users
- **GET** `/api/users/<id>` - Get user by ID
- **POST** `/api/users` - Create new user

### Health Check
- **GET** `/api/health` - Server health status

## 🧪 Testing with Postman

### 1. Test Server Connection
```
GET http://localhost:8080/api/test
```

### 2. Get All Users
```
GET http://localhost:8080/api/users
```

### 3. Create New User
```
POST http://localhost:8080/api/users
Content-Type: application/json

{
  "name": "Your Name",
  "email": "your.email@example.com"
}
```

### 4. Get User by ID
```
GET http://localhost:8080/api/users/1
```

## 📁 Project Structure

```
backend/
├── bin/
│   └── server.dart          # Main server entry point
├── lib/
├── models/
│   └── user_model.dart      # User data model
├── routes/
│   └── api_routes.dart      # API route handlers
└── README.md               # This file
```

## 🔧 Technologies Used

- **Dart** - Programming language
- **Shelf** - Web server framework
- **Shelf Router** - Routing middleware
- **Shelf CORS Headers** - CORS support
- **HTTP** - HTTP client package

## 📝 Response Format

All API responses return JSON format:

```json
{
  "message": "Success message",
  "data": {...},
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

## 🛠️ Development

To add new endpoints:
1. Define routes in `routes/api_routes.dart`
2. Create models in `models/` directory
3. Restart server to see changes
