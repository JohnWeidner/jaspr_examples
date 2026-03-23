/// The entrypoint for the **server** environment.
///
/// The [main] method will only be executed on the server during pre-rendering.
/// To run code on the client, check the `main.client.dart` file.
library;

import 'package:jaspr/server.dart';

import 'package:jaspr_snake/main.server.options.dart';
import 'package:jaspr_snake/snake_component.dart';

void main() {
  Jaspr.initializeApp(
    options: defaultServerOptions,
  );

  runApp(
    const Document(
      title: 'Jaspr Snake',
      head: [
        Component.element(
          tag: 'link',
          attributes: {'rel': 'stylesheet', 'href': '/styles.css'},
        ),
      ],
      body: SnakeComponent(),
    ),
  );
}
