import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_flutter_embed/jaspr_flutter_embed.dart';
import 'package:jaspr_server_example/live_clock.dart';
import 'package:jaspr_server_example/snake_game_section.dart';

@Import.onWeb('widgets/hello_flutter.dart', show: [#HelloFlutter])
import 'app_component.imports.dart';

/// The top-level app layout.
///
/// This component is rendered on the server for every request.
class AppComponent extends StatelessComponent {
  /// Creates an [AppComponent].
  const AppComponent({super.key});

  static String _pad(int n) => n.toString().padLeft(2, '0');

  @override
  Component build(BuildContext context) {
    final serverTime = DateTime.now();

    return div([
      const h1([Component.text('Jaspr Server Mode Demo')]),
      const p([
        Component.text(
          'A demo of Jaspr server mode \u2014 the page is rendered fresh '
          'on every request with live server state.',
        ),
      ], classes: 'subtitle'),

      // Server-rendered time (fresh on every request)
      div([
        const h2([Component.text('Server-Rendered Time')]),
        p([
          Component.text(
            '${_pad(serverTime.hour)}:${_pad(serverTime.minute)}:'
            '${_pad(serverTime.second)}',
          ),
        ], classes: 'time'),
        const p([
          Component.text(
            'This value was set when the server handled your request. '
            'Refresh the page to see it update.',
          ),
        ], classes: 'hint'),
      ], classes: 'card server-card'),

      const hr(),

      const p([
        Component.text(
          'The clocks below are inside a @client component. '
          'They hydrate in the browser and update every second.',
        ),
      ], classes: 'subtitle'),

      const LiveClockClient(),

      const hr(),

      const SnakeGameSection(),

      const hr(),

      FlutterEmbedView(
        widget: kIsWeb ? HelloFlutter() : null,
        loader: const div([Component.text('Loading Flutter app...')]),
        constraints: ViewConstraints(
          minWidth: 300,
          minHeight: 400,
          maxWidth: double.infinity,
          maxHeight: double.infinity,
        ),
        classes: 'flutter-container',
      ),
    ], classes: 'app');
  }
}
