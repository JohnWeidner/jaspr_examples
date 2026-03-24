import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake/snake.dart';

void main() {
  runApp(const SnakeApp());
}

class SnakeApp extends StatelessWidget {
  const SnakeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Snake',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1a1a2e),
      ),
      home: const SnakePage(),
    );
  }
}

class SnakePage extends StatefulWidget {
  const SnakePage({super.key});

  @override
  State<SnakePage> createState() => _SnakePageState();
}

class _SnakePageState extends State<SnakePage> {
  final SnakeGame _game = SnakeGame();
  Timer? _timer;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    Direction? dir;
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowUp:
        dir = Direction.up;
      case LogicalKeyboardKey.arrowDown:
        dir = Direction.down;
      case LogicalKeyboardKey.arrowLeft:
        dir = Direction.left;
      case LogicalKeyboardKey.arrowRight:
        dir = Direction.right;
    }

    if (dir == null) {
      if (_game.state == GameState.gameOver &&
          event.logicalKey == LogicalKeyboardKey.keyR) {
        _resetGame();
      }
      return;
    }

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
      setState(() {
        _game.step();
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
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Focus(
        focusNode: _focusNode,
        onKeyEvent: (_, event) {
          _handleKeyEvent(event);
          return KeyEventResult.handled;
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'SNAKE',
                style: TextStyle(
                  fontSize: 32,
                  letterSpacing: 8,
                  color: Color(0xFFe94560),
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Score: ${_game.score}',
                style: const TextStyle(
                  fontSize: 18,
                  letterSpacing: 2,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 16),
              _SnakeGrid(game: _game),
              const SizedBox(height: 16),
              if (_game.state == GameState.notStarted)
                const Text(
                  'Press an arrow key to start.',
                  style: TextStyle(color: Color(0xFFaaaaaa)),
                )
              else if (_game.state == GameState.gameOver)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Game Over!  Score: ${_game.score}',
                      style: const TextStyle(
                        color: Color(0xFFe94560),
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _resetGame,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFe94560),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text('Play Again'),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Or press R to restart.',
                      style: TextStyle(color: Color(0xFFaaaaaa)),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SnakeGrid extends StatelessWidget {
  const _SnakeGrid({required this.game});

  final SnakeGame game;

  static const _cellSize = 20.0;
  static const _borderColor = Color(0xFF444444);
  static const _emptyColor = Color(0xFF16213e);
  static const _headColor = Color(0xFF4ecca3);
  static const _bodyColor = Color(0xFF2e8b57);
  static const _foodColor = Color(0xFFe94560);

  Color _cellColor(int x, int y) {
    final pos = Position(x, y);
    if (game.snakeBody.isNotEmpty && game.snakeBody.first == pos) {
      return _headColor;
    }
    if (game.snakeBody.contains(pos)) return _bodyColor;
    if (game.state != GameState.notStarted && game.food == pos) {
      return _foodColor;
    }
    return _emptyColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: _borderColor, width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var y = 0; y < kGridHeight; y++)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var x = 0; x < kGridWidth; x++)
                  SizedBox(
                    width: _cellSize,
                    height: _cellSize,
                    child: ColoredBox(color: _cellColor(x, y)),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
