import 'dart:collection';
import 'dart:math';

import 'package:meta/meta.dart';

/// Width of the game grid in cells.
const int kGridWidth = 20;

/// Height of the game grid in cells.
const int kGridHeight = 20;

/// Direction of snake movement.
enum Direction {
  /// Moving up (decreasing y).
  up,

  /// Moving down (increasing y).
  down,

  /// Moving left (decreasing x).
  left,

  /// Moving right (increasing x).
  right,
}

/// Current state of the game.
enum GameState {
  /// Game has not started yet.
  notStarted,

  /// Game is in progress.
  playing,

  /// Game has ended due to a collision.
  gameOver,
}

/// A 2D grid position.
@immutable
class Position {
  /// Creates a [Position] at ([x], [y]).
  const Position(this.x, this.y);

  /// Horizontal coordinate (0 = left).
  final int x;

  /// Vertical coordinate (0 = top).
  final int y;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => Object.hash(x, y);
}

/// Core Snake game logic.
///
/// Does not notify listeners. Callers are responsible for triggering UI
/// rebuilds after calling [step]. No ChangeNotifier or Stream is used,
/// keeping this package UI-framework agnostic.
class SnakeGame {
  /// Creates a new [SnakeGame] with an optional [random] source.
  SnakeGame({Random? random}) : _random = random ?? Random() {
    _init();
  }

  final Random _random;
  final List<Position> _snakeBody = [];
  late Position _food;
  int _score = 0;
  GameState _state = GameState.notStarted;
  Direction _direction = Direction.right;
  Direction _nextDirection = Direction.right;

  /// The snake body. Head is the first element.
  ///
  /// Returns an [UnmodifiableListView] — callers cannot mutate game state
  /// directly.
  UnmodifiableListView<Position> get snakeBody =>
      UnmodifiableListView(_snakeBody);

  /// Current food position.
  Position get food => _food;

  /// Current score (number of food items eaten).
  int get score => _score;

  /// Current game state.
  GameState get state => _state;

  /// Transitions from [GameState.notStarted] to [GameState.playing].
  ///
  /// The game timer is owned by the caller.
  void start() {
    if (_state != GameState.notStarted) return;
    _state = GameState.playing;
  }

  /// Advances the game by one tick.
  ///
  /// Called by the caller's Timer.periodic. Sets [state] to
  /// [GameState.gameOver] on wall or self collision.
  void step() {
    if (_state != GameState.playing) return;

    _direction = _nextDirection;

    final head = _snakeBody.first;
    final newHead = switch (_direction) {
      Direction.up => Position(head.x, head.y - 1),
      Direction.down => Position(head.x, head.y + 1),
      Direction.left => Position(head.x - 1, head.y),
      Direction.right => Position(head.x + 1, head.y),
    };

    // Wall collision.
    if (newHead.x < 0 ||
        newHead.x >= kGridWidth ||
        newHead.y < 0 ||
        newHead.y >= kGridHeight) {
      _state = GameState.gameOver;
      return;
    }

    // Self collision — exclude the tail since it will be removed this tick.
    if (_snakeBody.sublist(0, _snakeBody.length - 1).contains(newHead)) {
      _state = GameState.gameOver;
      return;
    }

    _snakeBody.insert(0, newHead);

    if (newHead == _food) {
      _score++;
      _placeFood();
    } else {
      _snakeBody.removeLast();
    }
  }

  /// Changes the snake's direction.
  ///
  /// No-op if [dir] is the opposite of the current direction, preventing
  /// immediate self-collision.
  void changeDirection(Direction dir) {
    final isOpposite = switch (dir) {
      Direction.up => _direction == Direction.down,
      Direction.down => _direction == Direction.up,
      Direction.left => _direction == Direction.right,
      Direction.right => _direction == Direction.left,
    };
    if (!isOpposite) _nextDirection = dir;
  }

  /// Resets the game to [GameState.notStarted].
  void reset() => _init();

  /// The current food position. Exposed for testing only.
  @visibleForTesting
  Position get foodForTesting => _food;

  /// Overrides the food position. For testing only.
  @visibleForTesting
  set foodForTesting(Position position) => _food = position;

  void _init() {
    _snakeBody
      ..clear()
      ..addAll([
        const Position(10, 10),
        const Position(9, 10),
        const Position(8, 10),
      ]);
    _direction = Direction.right;
    _nextDirection = Direction.right;
    _score = 0;
    _state = GameState.notStarted;
    _placeFood();
  }

  void _placeFood() {
    const maxAttempts = kGridWidth * kGridHeight;
    Position candidate;
    var attempts = 0;
    do {
      candidate = Position(
        _random.nextInt(kGridWidth),
        _random.nextInt(kGridHeight),
      );
      attempts++;
    } while (_snakeBody.contains(candidate) && attempts < maxAttempts);
    _food = candidate;
  }
}
