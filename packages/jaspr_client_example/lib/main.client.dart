/// The entrypoint for the **client** environment.
///
/// In client mode, everything runs in the browser. There is no server
/// pre-rendering step — the component mounts directly to the DOM.
library;

import 'package:jaspr/client.dart';
import 'package:jaspr_client_example/app_component.dart';
import 'package:jaspr_client_example/main.client.options.dart';

void main() {
  Jaspr.initializeApp(options: defaultClientOptions);

  runApp(const AppComponent());
}
