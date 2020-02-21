import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tip_flutter_debug_tool/logger/log_console.dart';

class LogConsoleWidget extends StatefulWidget {
  final Widget child;
  final bool dark;
  final bool debugOnly;

  LogConsoleWidget({
    @required this.child,
    this.dark,
    this.debugOnly = true,
  });

  @override
  _LogConsoleWidgetState createState() => _LogConsoleWidgetState();
}

class _LogConsoleWidgetState extends State<LogConsoleWidget> {
  bool _open = false;

  @override
  void initState() {
    super.initState();

    if (widget.debugOnly) {
      assert(() {
        _init();
        return true;
      }());
    } else {
      _init();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  _init() {
    LogConsole.init();
  }

  openLogConsole() async {
    if (_open) return;

    _open = true;

    var logConsole = LogConsole(
      showCloseButton: true,
      dark: widget.dark ?? Theme.of(context).brightness == Brightness.dark,
    );
    PageRoute route;
    if (Platform.isIOS) {
      route = CupertinoPageRoute(builder: (_) => logConsole);
    } else {
      route = MaterialPageRoute(builder: (_) => logConsole);
    }

    await Navigator.push(context, route);
    _open = false;
  }

  @override
  void dispose() {
    super.dispose();
  }
}