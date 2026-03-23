import 'package:flutter/widgets.dart';

/// A minimal Flutter widget for testing jaspr_flutter_embed.
class HelloFlutter extends StatelessWidget {
  /// Creates a [HelloFlutter].
  const HelloFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFF2196F3),
      child: Center(
        child: Text(
          'Hello from Flutter!',
          textDirection: TextDirection.ltr,
          style: TextStyle(fontSize: 32, color: Color(0xFFFFFFFF)),
        ),
      ),
    );
  }
}
