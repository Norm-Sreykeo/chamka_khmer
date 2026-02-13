import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/user_model.dart';

class ApiRoutes {
  Router get router {
    final app = Router();

    // Test endpoint for Postman
    app.get('/api/test', (Request request) {
      return Response.ok(
        jsonEncode({
          'message': 'Hello from Dart Backend!',
          'status': 'success',
          'timestamp': DateTime.now().toIso8601String(),
        }),
        headers: {'Content-Type': 'application/json'},
      );
    });

    // Get all users
    app.get('/api/users', (Request request) {
      final users = [
        User(id: 1, name: 'Sok Dara', email: 'sokdara@example.com'),
        User(id: 2, name: 'Chan Srey', email: 'chansrey@example.com'),
        User(id: 3, name: 'Pich Vannak', email: 'pichvannak@example.com'),
      ];

      return Response.ok(
        jsonEncode({
          'users': users.map((user) => user.toJson()).toList(),
          'count': users.length,
        }),
        headers: {'Content-Type': 'application/json'},
      );
    });

    // Get user by ID
    app.get('/api/users/<id>', (Request request, String id) {
      final userId = int.tryParse(id) ?? 0;
      
      if (userId == 1) {
        final user = User(id: 1, name: 'Sok Dara', email: 'sokdara@example.com');
        return Response.ok(
          jsonEncode(user.toJson()),
          headers: {'Content-Type': 'application/json'},
        );
      } else {
        return Response.notFound(
          jsonEncode({'error': 'User not found'}),
          headers: {'Content-Type': 'application/json'},
        );
      }
    });

    // Create new user
    app.post('/api/users', (Request request) async {
      try {
        final body = await request.readAsString();
        final data = jsonDecode(body) as Map<String, dynamic>;
        
        final user = User(
          id: DateTime.now().millisecondsSinceEpoch,
          name: data['name'] ?? 'Unknown',
          email: data['email'] ?? 'unknown@example.com',
        );

        return Response(201,
          body: jsonEncode({
            'message': 'User created successfully',
            'user': user.toJson(),
          }),
          headers: {'Content-Type': 'application/json'},
        );
      } catch (e) {
        return Response(400,
          body: jsonEncode({'error': 'Invalid request body'}),
          headers: {'Content-Type': 'application/json'},
        );
      }
    });

    // Health check endpoint
    app.get('/api/health', (Request request) {
      return Response.ok(
        jsonEncode({
          'status': 'healthy',
          'timestamp': DateTime.now().toIso8601String(),
          'version': '1.0.0',
        }),
        headers: {'Content-Type': 'application/json'},
      );
    });

    return app;
  }
}
