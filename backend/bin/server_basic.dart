import 'dart:convert';
import 'dart:io';

void main() async {
  final server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);

  print('🚀 Server running on http://${server.address.host}:${server.port}');
  print('📡 API available at: http://localhost:8080/api');
  print('🧪 Test with Postman: http://localhost:8080/api/test');

  await for (HttpRequest request in server) {
    // Set CORS headers
    request.response.headers.set('Access-Control-Allow-Origin', '*');
    request.response.headers.set(
      'Access-Control-Allow-Methods',
      'GET, POST, PUT, DELETE, OPTIONS',
    );
    request.response.headers.set('Access-Control-Allow-Headers', '*');
    request.response.headers.set('Content-Type', 'application/json');

    // Handle OPTIONS preflight
    if (request.method == 'OPTIONS') {
      request.response.statusCode = HttpStatus.ok;
      await request.response.close();
      continue;
    }

    final path = request.uri.path;
    final method = request.method;

    try {
      switch ('${method} $path') {
        case 'GET /api/test':
          final data = {
            'message': 'Hello from Dart Backend!',
            'status': 'success',
            'timestamp': DateTime.now().toIso8601String(),
          };
          request.response.statusCode = HttpStatus.ok;
          request.response.write(jsonEncode(data));
          break;

        case 'GET /api/users':
          final users = [
            {'id': 1, 'name': 'Sok Dara', 'email': 'sokdara@example.com'},
            {'id': 2, 'name': 'Chan Srey', 'email': 'chansrey@example.com'},
            {'id': 3, 'name': 'Pich Vannak', 'email': 'pichvannak@example.com'},
          ];

          final data = {'users': users, 'count': users.length};
          request.response.statusCode = HttpStatus.ok;
          request.response.write(jsonEncode(data));
          break;

        case 'GET /api/health':
          final data = {
            'status': 'healthy',
            'timestamp': DateTime.now().toIso8601String(),
            'version': '1.0.0',
          };
          request.response.statusCode = HttpStatus.ok;
          request.response.write(jsonEncode(data));
          break;

        case 'POST /api/users':
          final body = await utf8.decoder.bind(request).join();
          final userData = jsonDecode(body) as Map<String, dynamic>;

          final newUser = {
            'id': DateTime.now().millisecondsSinceEpoch,
            'name': userData['name'] ?? 'Unknown',
            'email': userData['email'] ?? 'unknown@example.com',
          };

          final response = {
            'message': 'User created successfully',
            'user': newUser,
          };
          request.response.statusCode = HttpStatus.created;
          request.response.write(jsonEncode(response));
          break;

        default:
          final error = {'error': 'Endpoint not found'};
          request.response.statusCode = HttpStatus.notFound;
          request.response.write(jsonEncode(error));
          break;
      }
    } catch (e) {
      final error = {'error': 'Internal server error: $e'};
      request.response.statusCode = HttpStatus.internalServerError;
      request.response.write(jsonEncode(error));
    }

    await request.response.close();
  }
}
