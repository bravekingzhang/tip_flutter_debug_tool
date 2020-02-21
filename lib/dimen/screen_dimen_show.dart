import 'package:flutter/material.dart';

class DimenShow extends StatefulWidget {
  @override
  _DimenShowState createState() => _DimenShowState();
}

class _DimenShowState extends State<DimenShow> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('MediaQueryData'),
      ),
      body: ListView(
        children: <Widget>[
          DebugDrawerField(
              label: "Size.width",
              value: "width: ${mediaQuery.size.width.toStringAsFixed(2)}"),
          DebugDrawerField(
            label: "size.height",
            value: "height: ${mediaQuery.size.height.toStringAsFixed(2)}",
          ),
          DebugDrawerField(
            label: "PixelRatio",
            value: "${mediaQuery.devicePixelRatio}",
          ),
          DebugDrawerField(
            label: "Orientation",
            value: "${mediaQuery.orientation.toString()}",
          ),
          DebugDrawerField(
            label: "Platform Brightness",
            value: "${mediaQuery.platformBrightness}",
          ),
          DebugDrawerField(
            label: "Text scale factor",
            value: "${mediaQuery.textScaleFactor}",
          ),
          DebugDrawerField(
            label: "PixelRatio",
            value: "${mediaQuery.textScaleFactor}",
          ),
        ],
      ),
    );
  }
}

class DebugDrawerField extends StatelessWidget {
  final String label;
  final String value;

  DebugDrawerField({Key key, this.label, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      alignment: Alignment.topLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(right: 8),
              width: 120,
              child: Text(
                "$label:",
              )),
          Expanded(
            child: Text(
              value,
            ),
          ),
        ],
      ),
    );
  }
}
