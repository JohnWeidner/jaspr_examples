import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// A component that displays several live-updating time values.
///
/// On the server (`kIsWeb == false`), `build()` runs once to produce a static
/// snapshot. In the browser, a periodic timer starts in `initState()` and calls
/// `setState()` every second to keep the clocks ticking.
///
/// This component has **no** `@client` annotation so it can be shared across
/// Jaspr projects regardless of rendering mode. In static/server mode, wrap it
/// in a thin `@client` component to mark the hydration boundary.
class LiveClock extends StatefulComponent {
  /// Creates a [LiveClock].
  const LiveClock({super.key});

  @override
  State<LiveClock> createState() => _LiveClockState();
}

class _LiveClockState extends State<LiveClock> {
  Timer? _timer;
  DateTime _now = DateTime.now();
  late final DateTime _pageLoadTime;
  bool _isLive = false;

  @override
  void initState() {
    super.initState();
    _pageLoadTime = _now;

    // Only start the timer in the browser — not during server pre-rendering.
    if (!kIsWeb) return;

    _isLive = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _currentMode {
    if (kIsWeb) return 'client';
    if (kGenerateMode) return 'static';
    return 'server';
  }

  Component _modeRow(
    String label,
    bool isWeb,
    bool isGenerate,
    String mode,
  ) {
    final active = _currentMode == mode;
    return Component.element(
      tag: 'tr',
      attributes: active ? {'class': 'active-mode'} : {},
      children: [
        Component.element(tag: 'td', children: [Component.text(label)]),
        Component.element(
          tag: 'td',
          children: [Component.text(isWeb.toString())],
        ),
        Component.element(
          tag: 'td',
          children: [Component.text(isGenerate.toString())],
        ),
        Component.element(
          tag: 'td',
          children: [Component.text(active ? '\u2714' : '')],
        ),
      ],
    );
  }

  String _pad(int n) => n.toString().padLeft(2, '0');

  String _formatTime(DateTime dt) =>
      '${_pad(dt.hour)}:${_pad(dt.minute)}:${_pad(dt.second)}';

  String _formatDate(DateTime dt) =>
      '${dt.year}-${_pad(dt.month)}-${_pad(dt.day)}';

  String _formatElapsed() {
    final diff = _now.difference(_pageLoadTime);
    final h = diff.inHours;
    final m = diff.inMinutes.remainder(60);
    final s = diff.inSeconds.remainder(60);
    return '${_pad(h)}:${_pad(m)}:${_pad(s)}';
  }

  @override
  Component build(BuildContext context) {
    final utcNow = _now.toUtc();

    return div(
      [
        // Status badge
        div(
          [
            span(
              [Component.text(_isLive ? 'LIVE' : 'STATIC SNAPSHOT')],
              classes: _isLive ? 'badge live' : 'badge static',
            ),
            if (!_isLive)
              const p(
                [
                  Component.text(
                    'This is the server-rendered snapshot. '
                    'Once JavaScript loads, the clock will start ticking.',
                  ),
                ],
                classes: 'hint',
              ),
          ],
          classes: 'status',
        ),

        // Mode detection table
        div(
          [
            const h2([Component.text('Detected Mode')]),
            Component.element(
              tag: 'table',
              children: [
                const Component.element(
                  tag: 'thead',
                  children: [
                    Component.element(
                      tag: 'tr',
                      children: [
                        Component.element(
                          tag: 'th',
                          children: [Component.text('Scenario')],
                        ),
                        Component.element(
                          tag: 'th',
                          children: [Component.text('kIsWeb')],
                        ),
                        Component.element(
                          tag: 'th',
                          children: [Component.text('kGenerateMode')],
                        ),
                        Component.element(
                          tag: 'th',
                          children: [Component.text('')],
                        ),
                      ],
                    ),
                  ],
                ),
                Component.element(
                  tag: 'tbody',
                  children: [
                    _modeRow('Static pre-render', false, true, 'static'),
                    _modeRow('Server pre-render', false, false, 'server'),
                    _modeRow('Client (browser)', true, false, 'client'),
                  ],
                ),
              ],
            ),
          ],
          classes: 'card mode-card',
        ),

        // Local time
        div(
          [
            const h2([Component.text('Local Time')]),
            p([Component.text(_formatTime(_now))], classes: 'time'),
            p([Component.text(_formatDate(_now))], classes: 'date'),
          ],
          classes: 'card',
        ),

        // UTC time
        div(
          [
            const h2([Component.text('UTC Time')]),
            p([Component.text(_formatTime(utcNow))], classes: 'time'),
            p([Component.text(_formatDate(utcNow))], classes: 'date'),
          ],
          classes: 'card',
        ),

        // Elapsed time since page load
        div(
          [
            const h2([Component.text('Time on Page')]),
            p([Component.text(_formatElapsed())], classes: 'time'),
            const p(
              [Component.text('Since client hydration')],
              classes: 'date',
            ),
          ],
          classes: 'card',
        ),

        // Unix timestamp
        div(
          [
            const h2([Component.text('Unix Timestamp')]),
            p(
              [Component.text('${_now.millisecondsSinceEpoch ~/ 1000}')],
              classes: 'time mono',
            ),
            p(
              [Component.text('ms: ${_now.millisecondsSinceEpoch}')],
              classes: 'date mono',
            ),
          ],
          classes: 'card',
        ),
      ],
      classes: 'clock-grid',
    );
  }
}
