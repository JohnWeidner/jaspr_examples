import 'package:jaspr/jaspr.dart';
import 'package:jaspr_snake/snake_component.dart';

/// A `@client` hydration wrapper around [SnakeComponent].
///
/// Use this in static and client mode packages where no server-side callback
/// (like score reporting) is needed. The `@client` annotation marks the
/// hydration boundary; [SnakeComponent] runs entirely inside it.
@client
class ClientSnakeComponent extends StatelessComponent {
  /// Creates a [ClientSnakeComponent].
  const ClientSnakeComponent({super.key});

  @override
  Component build(BuildContext context) {
    return const SnakeComponent();
  }
}
