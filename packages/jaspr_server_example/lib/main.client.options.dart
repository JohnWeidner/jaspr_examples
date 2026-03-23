// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/client.dart';

import 'package:jaspr_server_example/live_clock.dart' deferred as _live_clock;
import 'package:jaspr_server_example/snake_game_section.dart'
    deferred as _snake_game_section;

/// Default [ClientOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.client.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultClientOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ClientOptions get defaultClientOptions => ClientOptions(
  clients: {
    'live_clock': ClientLoader(
      (p) => _live_clock.LiveClockClient(),
      loader: _live_clock.loadLibrary,
    ),
    'snake_game_section': ClientLoader(
      (p) => _snake_game_section.SnakeGameSection(),
      loader: _snake_game_section.loadLibrary,
    ),
  },
);
