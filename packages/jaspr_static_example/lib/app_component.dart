import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_snake/client_snake_component.dart';
import 'package:jaspr_static_example/client_flutter_app.dart';
import 'package:jaspr_static_example/live_clock.dart';

/// The top-level app layout.
///
/// This component is rendered once at build time to produce static HTML.
/// The timestamp is frozen in the output and never changes.
class AppComponent extends StatelessComponent {
  /// Creates an [AppComponent].
  const AppComponent({super.key});

  static String _pad(int n) => n.toString().padLeft(2, '0');

  @override
  Component build(BuildContext context) {
    final buildTime = DateTime.now();

    return div([
      const h1([Component.text('Jaspr Static Mode Demo')]),
      const p([
        Component.text(
          'A demo of how Jaspr rendering modes affect what you see.',
        ),
      ], classes: 'subtitle'),

      // Build-time rendered section (frozen in the static HTML)
      div([
        const h2([Component.text('Build-Time Rendered Time')]),
        p([
          Component.text(
            '${_pad(buildTime.hour)}:${_pad(buildTime.minute)}:'
            '${_pad(buildTime.second)}',
          ),
        ], classes: 'time'),
        const p([
          Component.text(
            'This value was set when the page was pre-rendered. '
            'It will never change \u2014 even if you wait. '
            'This is what static mode produces.',
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

      const ClientSnakeComponent(),

      const ClientFlutterApp(),
    ], classes: 'app');
  }
}
