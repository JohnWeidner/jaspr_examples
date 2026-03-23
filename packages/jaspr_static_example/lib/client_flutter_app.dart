import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_flutter_embed/jaspr_flutter_embed.dart';

@Import.onWeb('widgets/hello_flutter.dart', show: [#HelloFlutter])
import 'client_flutter_app.imports.dart' deferred as flutter_app;

/// A @client wrapper that hydrates in the browser and loads the Flutter app.
@client
class ClientFlutterApp extends StatelessComponent {
  /// Creates a [ClientFlutterApp].
  const ClientFlutterApp({super.key});

  @override
  Component build(BuildContext context) {
    return FlutterEmbedView.deferred(
      loadLibrary: flutter_app.loadLibrary(),
      builder: () => flutter_app.HelloFlutter(),
      loader: const div([Component.text('Loading Flutter app...')]),
      constraints: ViewConstraints(
        minWidth: 300,
        minHeight: 400,
        maxWidth: double.infinity,
        maxHeight: double.infinity,
      ),
      classes: 'flutter-container',
    );
  }
}
