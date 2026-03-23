/// The entrypoint for the **client** environment.
///
/// The [main] method will only be executed on the client when loading the
/// page. To run code on the server during pre-rendering, check the
/// `main.server.dart` file.
library;

// Client-specific Jaspr import.
import 'package:jaspr/client.dart';

// main.client.options.dart will be generated automatically
// when you run `jaspr build` or `jaspr serve`
import 'package:jaspr_server_example/main.client.options.dart';

void main() {
  Jaspr.initializeApp(options: defaultClientOptions);
  runApp(const ClientApp());
}
