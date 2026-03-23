// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/client.dart';

import 'package:jaspr_snake/client_snake_component.dart'
    deferred as _client_snake_component;
import 'package:jaspr_static_example/client_flutter_app.dart'
    deferred as _client_flutter_app;
import 'package:jaspr_static_example/live_clock.dart' deferred as _live_clock;

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
    'jaspr_snake:client_snake_component': ClientLoader(
      (p) => _client_snake_component.ClientSnakeComponent(),
      loader: _client_snake_component.loadLibrary,
    ),
    'client_flutter_app': ClientLoader(
      (p) => _client_flutter_app.ClientFlutterApp(),
      loader: _client_flutter_app.loadLibrary,
    ),
    'live_clock': ClientLoader(
      (p) => _live_clock.LiveClockClient(),
      loader: _live_clock.loadLibrary,
    ),
  },
);
