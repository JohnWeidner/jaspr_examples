import 'dart:async';
import 'dart:convert';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_snake/snake_component.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

/// A @client component that wraps the snake game with name entry and
/// server-side high scores.
///
/// Flow:
/// 1. Shows a name entry form and the current high score table.
/// 2. After the player enters their name, the snake game starts.
/// 3. Score changes are reported to the server via `POST /api/scores`.
/// 4. A poll timer fetches `GET /api/scores` every 3 seconds so the
///    high score table stays current across all connected players.
@client
class SnakeGameSection extends StatefulComponent {
  /// Creates a [SnakeGameSection].
  const SnakeGameSection({super.key});

  @override
  State<SnakeGameSection> createState() => _SnakeGameSectionState();
}

class _SnakeGameSectionState extends State<SnakeGameSection> {
  String? _playerName;
  Timer? _pollTimer;
  int _lastReportedScore = 0;
  List<Map<String, dynamic>> _highScores = [];

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) return;

    // Fetch high scores immediately so they show before the game starts.
    _fetchHighScores();
    _pollTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _fetchHighScores(),
    );
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Server communication
  // ---------------------------------------------------------------------------

  Future<void> _fetchHighScores() async {
    try {
      final response = await web.window.fetch('/api/scores'.toJS).toDart;
      final text = await response.text().toDart;
      final list = (jsonDecode(text.toDart) as List<dynamic>)
          .cast<Map<String, dynamic>>();
      setState(() => _highScores = list);
    } on Object {
      // Silently ignore fetch errors (e.g. server not reachable).
    }
  }

  void _onScoreChanged(int score) {
    if (score <= _lastReportedScore) return;
    _lastReportedScore = score;

    final body = jsonEncode({
      'name': _playerName,
      'score': score,
    });

    final headers = web.Headers()..append('Content-Type', 'application/json');

    // Fire-and-forget POST; update high scores from the response.
    web.window
        .fetch(
          '/api/scores'.toJS,
          web.RequestInit(
            method: 'POST',
            headers: headers,
            body: body.toJS,
          ),
        )
        .toDart
        .then((response) async {
      final text = await response.text().toDart;
      final list = (jsonDecode(text.toDart) as List<dynamic>)
          .cast<Map<String, dynamic>>();
      setState(() => _highScores = list);
    }).catchError((Object _) {
      // Ignore errors.
    });
  }

  // ---------------------------------------------------------------------------
  // Name submission
  // ---------------------------------------------------------------------------

  void _submitName() {
    final input = web.document.getElementById('snake-name-input');
    if (input == null) return;
    final value = (input as web.HTMLInputElement).value.trim();
    if (value.isEmpty) return;
    setState(() {
      _playerName = value;
      _lastReportedScore = 0;
    });
  }

  // ---------------------------------------------------------------------------
  // Rendering helpers
  // ---------------------------------------------------------------------------

  Component _buildHighScoreTable() {
    return div([
      const h2([Component.text('High Scores')]),
      if (_highScores.isEmpty)
        const p([
          Component.text('No scores yet. Be the first!'),
        ], classes: 'empty-message')
      else
        Component.element(
          tag: 'table',
          children: [
            const Component.element(
              tag: 'thead',
              children: [
                Component.element(
                  tag: 'tr',
                  children: [
                    Component.element(
                      tag: 'th',
                      children: [Component.text('#')],
                      classes: 'rank',
                    ),
                    Component.element(
                      tag: 'th',
                      children: [Component.text('Player')],
                      classes: 'player-name',
                    ),
                    Component.element(
                      tag: 'th',
                      children: [Component.text('Score')],
                      classes: 'player-score',
                    ),
                  ],
                ),
              ],
            ),
            Component.element(
              tag: 'tbody',
              children: [
                for (var i = 0; i < _highScores.length; i++)
                  Component.element(
                    tag: 'tr',
                    children: [
                      Component.element(
                        tag: 'td',
                        children: [Component.text('${i + 1}')],
                        classes: 'rank',
                      ),
                      Component.element(
                        tag: 'td',
                        children: [
                          Component.text(
                            '${_highScores[i]['name']}',
                          ),
                        ],
                        classes: 'player-name',
                      ),
                      Component.element(
                        tag: 'td',
                        children: [
                          Component.text(
                            '${_highScores[i]['score']}',
                          ),
                        ],
                        classes: 'player-score',
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
    ], classes: 'high-scores');
  }

  Component _buildNameForm() {
    return div([
      const h2([Component.text('Enter Your Name to Play')]),
      div([
        input(
          type: InputType.text,
          attributes: const {
            'placeholder': 'Your name',
            'id': 'snake-name-input',
            'autocomplete': 'off',
          },
          events: {
            'keydown': (event) {
              final kbEvent = event as web.KeyboardEvent;
              if (kbEvent.key == 'Enter') _submitName();
            },
          },
        ),
        button(
          const [Component.text('Play!')],
          events: {'click': (_) => _submitName()},
        ),
      ], classes: 'name-form'),
    ]);
  }

  @override
  Component build(BuildContext context) {
    return div([
      if (_playerName == null) ...[
        const h1([Component.text('SNAKE')]),
        _buildNameForm(),
      ] else
        SnakeComponent(onScoreChanged: _onScoreChanged),
      _buildHighScoreTable(),
    ], classes: 'snake-game');
  }
}
