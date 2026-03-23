import 'package:jaspr/jaspr.dart';
import 'package:jaspr_time/jaspr_time.dart';

/// A thin `@client` wrapper around the shared [LiveClock] component.
///
/// In static mode, the `@client` annotation marks the hydration boundary.
/// The server pre-renders the component tree below this point, then the
/// browser takes over after JavaScript loads.
@client
class LiveClockClient extends StatelessComponent {
  /// Creates a [LiveClockClient].
  const LiveClockClient({super.key});

  @override
  Component build(BuildContext context) => const LiveClock();
}
