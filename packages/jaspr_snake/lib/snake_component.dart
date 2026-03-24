import 'dart:async';

// `Position` in package:jaspr/dom.dart is a CSS property value class.
// We hide it so `Position` unambiguously refers to the game grid position
// from package:snake.
import 'package:jaspr/dom.dart' hide Position;
import 'package:jaspr/jaspr.dart';
import 'package:snake/snake.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

/// The Jaspr Snake game component.
///
/// This component is NOT `@client` — it must be rendered inside a hydration
/// boundary (e.g. ClientSnakeComponent or another `@client` wrapper).
/// This allows callers to pass callbacks like [onScoreChanged].
class SnakeComponent extends StatefulComponent {
  /// Creates a [SnakeComponent].
  ///
  /// [onScoreChanged] is called whenever the score increases during gameplay.
  const SnakeComponent({this.onScoreChanged, super.key});

  /// Optional callback invoked with the new score each time it increases.
  final void Function(int score)? onScoreChanged;

  @override
  State<SnakeComponent> createState() => _SnakeComponentState();
}

class _SnakeComponentState extends State<SnakeComponent> {
  final SnakeGame _game = SnakeGame();
  Timer? _timer;

  // Stored so we can remove it in dispose().
  JSExportedDartFunction? _keydownListener;

  @override
  void initState() {
    super.initState();
    // Guard: server pre-render must not start timers or access web APIs.
    if (!kIsWeb) return;

    _keydownListener = ((JSAny? raw) {
      _handleKey(raw! as web.KeyboardEvent);
    }).toJS;
    web.document.addEventListener(
      'keydown',
      _keydownListener! as web.EventListener,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    final listener = _keydownListener;
    if (listener != null) {
      web.document.removeEventListener(
        'keydown',
        listener as web.EventListener,
      );
      _keydownListener = null;
    }
    super.dispose();
  }

  void _handleKey(web.KeyboardEvent event) {
    Direction? dir;
    switch (event.key) {
      case 'ArrowUp':
        dir = Direction.up;
      case 'ArrowDown':
        dir = Direction.down;
      case 'ArrowLeft':
        dir = Direction.left;
      case 'ArrowRight':
        dir = Direction.right;
    }

    if (dir == null) {
      if (_game.state == GameState.gameOver && event.key == 'r') {
        _resetGame();
      }
      return;
    }

    event.preventDefault();

    switch (_game.state) {
      case GameState.notStarted:
        _startGame(dir);
      case GameState.playing:
        setState(() => _game.changeDirection(dir!));
      case GameState.gameOver:
        break;
    }
  }

  void _startGame(Direction initialDirection) {
    setState(() {
      _game
        ..start()
        ..changeDirection(initialDirection);
    });
    _timer = Timer.periodic(const Duration(milliseconds: 150), (_) {
      final previousScore = _game.score;
      setState(() {
        _game.step();
        if (_game.score > previousScore) {
          component.onScoreChanged?.call(_game.score);
        }
        if (_game.state == GameState.gameOver) {
          _timer?.cancel();
          _timer = null;
        }
      });
    });
  }

  void _resetGame() {
    _timer?.cancel();
    _timer = null;
    setState(_game.reset);
  }

  String _cellClass(int x, int y) {
    final pos = Position(x, y);
    if (_game.snakeBody.isNotEmpty && _game.snakeBody.first == pos) {
      return 'cell head';
    }
    if (_game.snakeBody.contains(pos)) return 'cell body';
    if (_game.state != GameState.notStarted && _game.food == pos) {
      return 'cell food';
    }
    return 'cell';
  }

  @override
  Component build(BuildContext context) {
    return div([
      const h1([Component.text('SNAKE')]),
      p([Component.text('Score: ${_game.score}')], classes: 'score'),
      div([
        for (var y = 0; y < kGridHeight; y++)
          div([
            for (var x = 0; x < kGridWidth; x++)
              div(const <Component>[], classes: _cellClass(x, y)),
          ], classes: 'row'),
      ], classes: 'grid'),
      if (_game.state == GameState.notStarted)
        const p([
          Component.text('Press an arrow key to start.'),
        ], classes: 'message')
      else if (_game.state == GameState.gameOver)
        div([
          p([Component.text('Game Over!  Score: ${_game.score}')]),
          button(const [Component.text('Play Again')], onClick: _resetGame),
          const p([
            Component.text('Or press R to restart.'),
          ], classes: 'message'),
        ], classes: 'game-over'),
    ], classes: 'snake-game');
  }
}
