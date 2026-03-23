// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:jaspr_server_example/live_clock.dart' as _live_clock;
import 'package:jaspr_server_example/snake_game_section.dart'
    as _snake_game_section;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  clients: {
    _live_clock.LiveClockClient: ClientTarget<_live_clock.LiveClockClient>(
      'live_clock',
    ),
    _snake_game_section.SnakeGameSection:
        ClientTarget<_snake_game_section.SnakeGameSection>(
          'snake_game_section',
        ),
  },
);
