/// The entrypoint for the **server** environment.
///
/// The [main] method will only be executed on the server during pre-rendering.
/// To run code on the client, check the `main.client.dart` file.
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

import 'package:jaspr_static_example/app_component.dart';

// main.server.options.dart will be generated automatically
// when you run `jaspr build` or `jaspr serve`
import 'package:jaspr_static_example/main.server.options.dart';

void main() {
  Jaspr.initializeApp(options: defaultServerOptions);

  runApp(
    const Document(
      title: 'Jaspr Static',
      head: [
        Component.element(
          tag: 'link',
          attributes: {'rel': 'stylesheet', 'href': '/styles.css'},
        ),
        script(src: 'flutter_bootstrap.js', async: true),
      ],
      body: AppComponent(),
    ),
  );
}
