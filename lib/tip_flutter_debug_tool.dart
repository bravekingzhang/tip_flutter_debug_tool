library tip_flutter_debug_tool;

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tip_flutter_debug_tool/dimen/screen_dimen_show.dart';
import 'package:tip_flutter_debug_tool/inspector/widget_detector.dart';
import 'package:tip_flutter_debug_tool/logger/log_console.dart';
import 'package:tip_flutter_debug_tool/memory/image_memory_check.dart';
import 'package:tip_flutter_debug_tool/shake_detector.dart';
import 'package:synchronized/synchronized.dart';

class MyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}

class DebugTools {
  static final DebugTools _singleton = DebugTools._internal();

  var logger = Logger(
    filter: MyFilter(), // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );

  factory DebugTools() {
    return _singleton;
  }

  DebugTools._internal() {
    LogConsole.init();
  }

  BuildContext buildContext;

  bool _isPanelShow = false;
  ShakeDetector _shakeDetector;
  var lock = new Lock();

  void init(BuildContext buildContext) {
    if (this.buildContext != null || _shakeDetector != null) {
      return;
    }
    this.buildContext = buildContext;
    _shakeDetector = ShakeDetector.autoStart(onPhoneShake: () {
      lock.synchronized(() async {
        showPanel();
      });
    });
  }

  void dispose() {
    if (_shakeDetector != null) {
      _shakeDetector.stopListening();
    }
  }

  void showPanel() {
    if (_isPanelShow) {
      return;
    }
    _isPanelShow = true;
    //创建一个OverlayEntry对象
    OverlayEntry overlayEntry;
    overlayEntry = new OverlayEntry(builder: (context) {
      //外层使用Positioned进行定位，控制在Overlay中的位置
      return new Positioned(
          top: MediaQuery.of(context).size.height * 0.1,
          child: new Material(
            color: Colors.grey.shade200.withOpacity(0.8),
            child: new Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: new Center(
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset(
                        'images/console.png',
                        width: 24,
                        package: 'tip_flutter_debug_tool',
                      ),
                      onPressed: () {
                        logger.v("open debug pannel");
                        _closePanel(overlayEntry);
                        _openLogConsole();
                      },
                    ),
                    IconButton(
                      icon: Image.asset(
                        'images/view.png',
                        width: 24,
                        package: 'tip_flutter_debug_tool',
                      ),
                      onPressed: () {
                        logger.v("open debug pannel");
                        _closePanel(overlayEntry);
                        showWidgetInspect2(buildContext);
//                        showWidgetInspect(buildContext);
                      },
                    ),
                    IconButton(
                      icon: Image.asset(
                        'images/screen.png',
                        width: 24,
                        package: 'tip_flutter_debug_tool',
                      ),
                      onPressed: () {
                        logger.v("open dimen info");
                        _closePanel(overlayEntry);
                        _showDimenInfo();
                      },
                    ),
                    IconButton(
                      icon: Image.asset(
                        'images/memory.png',
                        width: 24,
                        package: 'tip_flutter_debug_tool',
                      ),
                      onPressed: () {
                        logger.v("open dimen info");
                        _closePanel(overlayEntry);
                        _showImageMemInfo();
                      },
                    ),
                    IconButton(
                      icon: Image.asset(
                        'images/close.png',
                        width: 24,
                        package: 'tip_flutter_debug_tool',
                      ),
                      onPressed: () {
                        _closePanel(overlayEntry);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
    Overlay.of(buildContext).insert(overlayEntry);
  }

  void _closePanel(OverlayEntry overlayEntry) {
    if (overlayEntry != null) {
      overlayEntry.remove();
      _isPanelShow = false;
      logger.v("close debug pannel");
    }
  }

  void _openLogConsole() async {
    LogConsole.init();
    var logConsole = LogConsole(
      showCloseButton: true,
      dark: Theme.of(buildContext).brightness == Brightness.dark,
    );
    PageRoute route;
    if (Platform.isIOS) {
      route = CupertinoPageRoute(builder: (_) => logConsole);
    } else {
      route = MaterialPageRoute(builder: (_) => logConsole);
    }
    Navigator.push(buildContext, route);
  }

  void _showDimenInfo() {
    PageRoute route;
    if (Platform.isIOS) {
      route = CupertinoPageRoute(builder: (_) => DimenShow());
    } else {
      route = MaterialPageRoute(builder: (_) => DimenShow());
    }
    Navigator.push(buildContext, route);
  }

  void _showImageMemInfo() {
    PageRoute route;
    if (Platform.isIOS) {
      route = CupertinoPageRoute(builder: (_) => ImageMemoryCheck());
    } else {
      route = MaterialPageRoute(builder: (_) => ImageMemoryCheck());
    }
    Navigator.push(buildContext, route);
  }

  void showWidgetInspect2(BuildContext context) {
    assert(context != null);
    Widget appWidget = WidgetDetector(child: context.widget, isEnabled: true);
    PageRoute route;
    route = MaterialPageRoute(
      builder: (_) => appWidget,
    );
    Navigator.push(buildContext, route);
  }

  void showWidgetInspect(BuildContext context) {
    assert(context != null);
    Widget child = context.widget;
    WidgetInspector widgetInspector = WidgetInspector(
      child: child,
      selectButtonBuilder: (BuildContext context, VoidCallback onPressed) {
        return FloatingActionButton(
          child: const Icon(Icons.search),
          onPressed: () {
            String selectNode = WidgetInspectorService.instance
                .getSelectedWidget(null, "temp");
            Map selectWidget = json.decode(selectNode);
            var properties = json.decode(WidgetInspectorService.instance
                .getProperties(selectWidget['objectId'], "temp"));
            logger.e(properties);
            onPressed();
          },
        );
      },
    );

//    TipWidgetInspectorService.instance.selection;
//    WidgetInspectorService.instance.getSelectedWidget(null, "temp")
//    WidgetInspectorService.instance.getRootWidget("temp");
//    WidgetInspectorService.instance.getDetailsSubtree("15", "temp");
//    WidgetInspectorService.instance.getChildrenDetailsSubtree("inspector-160", "temp");
//    WidgetInspectorService.instance.getSelectedWidget(null, "temp");
//    WidgetInspectorService.instance.getSelectedSummaryWidget(null, "temp")
//    WidgetInspectorService.instance.getProperties("inspector-3255","temp")
    PageRoute route;
    route = MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('选择控件进行调试'),
        ),
        body: widgetInspector,
      ),
    );
    Navigator.push(buildContext, route);
  }
}
