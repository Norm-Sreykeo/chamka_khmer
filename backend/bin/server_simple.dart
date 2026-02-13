import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

// Simple handler function
Response _handler(Request request) {
  final path = request.url.path;
  final method = request.method;

  // CORS preflight
  if (method == 'OPTIONS') {
    return Response.ok('', headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': '*',
    });
  }

  // Add CORS headers to all responses
  final headers = {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': '*',
  };

  switch ('${method} $path') {
    case 'GET api/test':
      return Response.ok(
        jsonEncode({
          'message': 'Hello from Dart Backend!',
          'status': 'success',
          'timestamp': DateTime.now().toIso8601String(),
        }),
        headers: headers,
      );

    case 'GET api/users':
      final users = [
        {'id': 1, 'name': 'Sok Dara', 'email': 'sokdara@example.com'},
        {'id': 2, 'name': 'Chan Srey', 'email': 'chansrey@example.com'},
        {'id': 3, 'name': 'Pich Vannak', 'email': 'pichvannak@example.com'},
      ];

      return Response.ok(
        jsonEncode({
          'users': users,
          'count': users.length,
        }),
        headers: headers,
      );

    case 'GET api/health':
      return Response.ok(
        jsonEncode({
          'status': 'healthy',
          'timestamp': DateTime.now().toIso8601String(),
          'version': '1.0.0',
        }),
        headers: headers,
      );

    default:
      return Response.notFound(
        jsonEncode({'error': 'Endpoint not found'}),
        headers: headers,
      );
  }
}

void main() async {
  // Create handler with CORS
  final handler = const Pipeline()
      .addMiddleware(corsHeaders(headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': '*',
      }))
      .addMiddleware(logRequests())
      .addHandler(_handler);

  // Start server
  final server = await shelf_io.serve(
    handler,
    InternetAddress.anyIPv4,
    8080,
  );

  print('🚀 Server running on http://${server.address.host}:${server.port}');
  print('📡 API available at: http://localhost:8080/api');
  print('🧪 Test with Postman: http://localhost:8080/api/test');
}
