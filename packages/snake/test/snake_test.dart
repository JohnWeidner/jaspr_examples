// Const constructors are suppressed to keep test values readable.
// ignore_for_file: prefer_const_constructors

import 'package:snake/snake.dart';
import 'package:test/test.dart';

void main() {
  group('SnakeGame', () {
    late SnakeGame game;

    setUp(() => game = SnakeGame());

    group('initial state', () {
      test('starts in notStarted', () {
        expect(game.state, GameState.notStarted);
      });

      test('score is 0', () {
        expect(game.score, 0);
      });

      test('snake has length 3', () {
        expect(game.snakeBody.length, 3);
      });

      test('snake starts at (10,10)', () {
        expect(game.snakeBody.first, const Position(10, 10));
      });
    });

    group('start()', () {
      test('transitions to playing', () {
        game.start();
        expect(game.state, GameState.playing);
      });

      test('is a no-op when already playing', () {
        game
          ..start()
          ..start();
        expect(game.state, GameState.playing);
      });

      test('is a no-op when gameOver', () {
        // Drive game to gameOver by hitting the right wall.
        game.start();
        for (var i = 0; i < kGridWidth + 1; i++) {
          if (game.state != GameState.playing) break;
          game.step();
        }
        expect(game.state, GameState.gameOver);
        game.start();
        expect(game.state, GameState.gameOver);
      });
    });

    group('step()', () {
      test('does nothing when notStarted', () {
        final body = game.snakeBody.toList();
        game.step();
        expect(game.snakeBody.toList(), body);
        expect(game.state, GameState.notStarted);
      });

      test('moves snake right by default', () {
        game.start();
        final head = game.snakeBody.first;
        game.step();
        expect(game.snakeBody.first, Position(head.x + 1, head.y));
      });

      test('maintains snake length when no food eaten', () {
        game
          ..start()
          ..foodForTesting = const Position(0, 19);
        final length = game.snakeBody.length;
        game.step();
        expect(game.snakeBody.length, length);
      });

      test('transitions to gameOver on right wall collision', () {
        game
          ..start()
          ..foodForTesting = const Position(0, 19);
        for (var i = 0; i < kGridWidth + 1; i++) {
          if (game.state != GameState.playing) break;
          game.step();
        }
        expect(game.state, GameState.gameOver);
      });

      test('transitions to gameOver on left wall collision', () {
        game
          ..start()
          ..changeDirection(Direction.left)
          ..foodForTesting = const Position(19, 19);
        for (var i = 0; i < kGridWidth + 1; i++) {
          if (game.state != GameState.playing) break;
          game.step();
        }
        expect(game.state, GameState.gameOver);
      });

      test('transitions to gameOver on top wall collision', () {
        game
          ..start()
          ..changeDirection(Direction.up)
          ..foodForTesting = const Position(19, 19);
        for (var i = 0; i < kGridHeight + 1; i++) {
          if (game.state != GameState.playing) break;
          game.step();
        }
        expect(game.state, GameState.gameOver);
      });

      test('transitions to gameOver on bottom wall collision', () {
        game
          ..start()
          ..changeDirection(Direction.down)
          ..foodForTesting = const Position(19, 0);
        for (var i = 0; i < kGridHeight + 1; i++) {
          if (game.state != GameState.playing) break;
          game.step();
        }
        expect(game.state, GameState.gameOver);
      });

      test('increments score when food is eaten', () {
        // Place food directly in the snake's path (one step to the right).
        game
          ..start()
          ..foodForTesting = Position(
            game.snakeBody.first.x + 1,
            game.snakeBody.first.y,
          )
          ..step();
        expect(game.score, 1);
      });

      test('grows snake when food is eaten', () {
        game.start();
        final length = game.snakeBody.length;
        game
          ..foodForTesting = Position(
            game.snakeBody.first.x + 1,
            game.snakeBody.first.y,
          )
          ..step();
        expect(game.snakeBody.length, length + 1);
      });
    });

    group('changeDirection()', () {
      test('changes direction', () {
        game
          ..start()
          ..changeDirection(Direction.up);
        final head = game.snakeBody.first;
        game.step();
        expect(game.snakeBody.first, Position(head.x, head.y - 1));
      });

      test('is a no-op for opposite direction (right vs left)', () {
        game
          ..start()
          ..changeDirection(Direction.left); // opposite of default right
        final head = game.snakeBody.first;
        game.step();
        // Should still move right.
        expect(game.snakeBody.first, Position(head.x + 1, head.y));
      });

      test('is a no-op for opposite direction (up vs down)', () {
        game
          ..start()
          ..changeDirection(Direction.up) // change to up
          ..step()
          ..changeDirection(Direction.down); // opposite — should be ignored
        final head = game.snakeBody.first;
        game.step();
        // Should still move up.
        expect(game.snakeBody.first, Position(head.x, head.y - 1));
      });
    });

    group('reset()', () {
      test('returns to notStarted', () {
        game
          ..start()
          ..reset();
        expect(game.state, GameState.notStarted);
      });

      test('resets score to 0', () {
        game
          ..start()
          ..foodForTesting = Position(
            game.snakeBody.first.x + 1,
            game.snakeBody.first.y,
          )
          ..step() // eat food, score = 1
          ..reset();
        expect(game.score, 0);
      });

      test('restores initial snake length', () {
        game
          ..start()
          ..reset();
        expect(game.snakeBody.length, 3);
      });

      test('restores initial snake position', () {
        game
          ..start()
          ..step()
          ..reset();
        expect(game.snakeBody.first, const Position(10, 10));
      });
    });

    group('snakeBody', () {
      test('returns an unmodifiable list', () {
        expect(
          () => game.snakeBody.add(const Position(0, 0)),
          throwsUnsupportedError,
        );
      });
    });
  });

  group('Position', () {
    test('equal positions are equal', () {
      expect(const Position(3, 4), equals(const Position(3, 4)));
    });

    test('different positions are not equal', () {
      expect(const Position(3, 4), isNot(equals(const Position(3, 5))));
      expect(const Position(3, 4), isNot(equals(const Position(4, 4))));
    });

    test('equal positions have the same hashCode', () {
      expect(
        const Position(3, 4).hashCode,
        equals(const Position(3, 4).hashCode),
      );
    });
  });

  group('GameState', () {
    test('has three values', () {
      expect(GameState.values, [
        GameState.notStarted,
        GameState.playing,
        GameState.gameOver,
      ]);
    });
  });

  group('Direction', () {
    test('has four values', () {
      expect(Direction.values, [
        Direction.up,
        Direction.down,
        Direction.left,
        Direction.right,
      ]);
    });
  });

  group('constants', () {
    test('kGridWidth is 20', () => expect(kGridWidth, 20));
    test('kGridHeight is 20', () => expect(kGridHeight, 20));
  });
}
