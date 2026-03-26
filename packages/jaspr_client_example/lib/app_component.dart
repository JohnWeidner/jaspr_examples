import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_snake/client_snake_component.dart';
import 'package:jaspr_snake/snake_component.dart';
import 'package:jaspr_time/jaspr_time.dart';

/// The top-level app layout for client mode.
///
/// Everything here runs entirely in the browser — there is no server
/// pre-rendering step. Both [LiveClock] and [ClientSnakeComponent] mount
/// directly to the DOM.
class AppComponent extends StatelessComponent {
  /// Creates an [AppComponent].
  const AppComponent({super.key});

  @override
  Component build(BuildContext context) {
    return const div([
      h1([Component.text('Jaspr Client Mode Example')]),
      p([
        Component.text(
          'A demo of Jaspr client mode \u2014 everything runs '
          'entirely in the browser, no server required.',
        ),
      ], classes: 'subtitle'),
      LiveClock(),
      hr(),
      SnakeComponent(),
    ], classes: 'app');
  }
}
