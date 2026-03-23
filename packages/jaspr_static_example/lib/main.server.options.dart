// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:jaspr_snake/client_snake_component.dart'
    as _client_snake_component;
import 'package:jaspr_static_example/client_flutter_app.dart'
    as _client_flutter_app;
import 'package:jaspr_static_example/live_clock.dart' as _live_clock;

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
    _client_snake_component.ClientSnakeComponent:
        ClientTarget<_client_snake_component.ClientSnakeComponent>(
          'jaspr_snake:client_snake_component',
        ),
    _client_flutter_app.ClientFlutterApp:
        ClientTarget<_client_flutter_app.ClientFlutterApp>(
          'client_flutter_app',
        ),
    _live_clock.LiveClockClient: ClientTarget<_live_clock.LiveClockClient>(
      'live_clock',
    ),
  },
);
