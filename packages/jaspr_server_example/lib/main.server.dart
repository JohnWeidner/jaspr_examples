/// The entrypoint for the **server** environment.
///
/// Uses [ServerApp.addMiddleware] to handle the snake game score API.
///
/// **Note:** middleware must only handle specific subpaths (like `api/scores`).
/// Catching all POST requests breaks `jaspr serve` dev mode because the dev
/// server uses internal POST requests for hot-reload communication.
/// See https://github.com/schultek/jaspr/issues/775
library;

import 'dart:convert';

import 'package:jaspr/server.dart';

import 'package:jaspr_server_example/app_component.dart';
import 'package:jaspr_server_example/main.server.options.dart';
import 'package:jaspr_server_example/server_state.dart';

/// Returns the current high scores as a JSON array.
Response _handleScoreGet() {
  return Response.ok(
    jsonEncode(highScores.map((e) => e.toJson()).toList()),
    headers: {'content-type': 'application/json'},
  );
}

/// Accepts a JSON body `{"name": "...", "score": N}`, upserts the high
/// score entry, and returns the updated list.
Future<Response> _handleScorePost(Request request) async {
  final body = await request.readAsString();
  final data = jsonDecode(body) as Map<String, dynamic>;
  final name = (data['name'] as String? ?? '').trim();
  final score = data['score'] as int? ?? 0;

  if (name.isNotEmpty && score > 0) {
    final existing = highScores.where((e) => e.name == name).firstOrNull;
    if (existing != null) {
      if (score > existing.score) existing.score = score;
    } else {
      highScores.add(HighScore(name: name, score: score, time: DateTime.now()));
    }
    highScores.sort((a, b) => b.score.compareTo(a.score));
    if (highScores.length > 10) highScores.removeRange(10, highScores.length);
  }

  return Response.ok(
    jsonEncode(highScores.map((e) => e.toJson()).toList()),
    headers: {'content-type': 'application/json'},
  );
}

void main() {
  Jaspr.initializeApp(options: defaultServerOptions);

  ServerApp.addMiddleware((innerHandler) {
    return (request) {
      // Score API routes.
      if (request.url.path == 'api/scores') {
        if (request.method == 'POST') return _handleScorePost(request);
        if (request.method == 'GET') return _handleScoreGet();
      }

      return innerHandler(request);
    };
  });

  runApp(
    const Document(
      title: 'Jaspr Server',
      head: [
        Component.element(
          tag: 'link',
          attributes: {'rel': 'stylesheet', 'href': '/styles.css'},
        ),
        Component.element(
          tag: 'script',
          attributes: {'src': 'flutter_bootstrap.js', 'async': ''},
        ),
      ],
      body: AppComponent(),
    ),
  );
}
