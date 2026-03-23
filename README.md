# Jaspr + Flutter Web Example

A monorepo demonstrating how to combine [Jaspr](https://jasprframework.dev) (for SEO-friendly, web-first pages) with Flutter Web (for interactive, app-like experiences) — both sharing pure Dart business logic. The demo uses the classic Snake game.

## Architecture

```
jaspr_flutter_web_example/
├── packages/
│   ├── snake/          # Pure Dart game logic — no UI dependencies
│   ├── jaspr_snake/    # Jaspr static site rendering the game in real DOM
│   └── flutter_snake/  # Flutter Web app rendering the same game
└── README.md
```

Both `jaspr_snake` and `flutter_snake` import `packages/snake` via a path dependency. No game logic is duplicated.

## Prerequisites

- Dart SDK `>=3.10.0`
- Flutter SDK (for `flutter_snake`)
- Jaspr CLI: `dart pub global activate jaspr_cli`

## Running

### Jaspr Snake

```sh
cd packages/jaspr_snake
dart pub get
jaspr serve
```

Open `http://localhost:8080` in a browser.

### Flutter Snake

```sh
cd packages/flutter_snake
flutter pub get
flutter run -d chrome
```

## Testing

### Snake (shared logic)

```sh
cd packages/snake
dart test
```

### Flutter Snake

```sh
cd packages/flutter_snake
flutter test
```
