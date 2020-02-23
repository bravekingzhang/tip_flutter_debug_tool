import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tip_flutter_debug_tool/tip_flutter_debug_tool.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runZoned(() => runApp(MyApp()), onError: (Object obj, StackTrace stack) {});
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    print(flutterErrorDetails.toString());
    return Center(
      child: Text("Flutter 走神了"),
    );
  };
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'flutter摇一摇调试工具'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    DebugTools().init(context);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: InkWell(onTap: () {}, child: Text(widget.title)),
      ),
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("左边文字"),
             CachedNetworkImage(
               imageUrl: "http://t7.baidu.com/it/u=3616242789,1098670747&fm=79&app=86&f=JPEG?w=900&h=1350",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              Text("右边文字")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("左边文字"),
              CachedNetworkImage(
                imageUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582469061411&di=1af1a4120044355cfd2644d5d788fcaf&imgtype=0&src=http%3A%2F%2Ft9.baidu.com%2Fit%2Fu%3D1307125826%2C3433407105%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D5760%26h%3D3240",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              Text("右边文字")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("左边文字"),
              CachedNetworkImage(
                imageUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582469061411&di=5034d74ae8baa7202e4af158317fdfcd&imgtype=0&src=http%3A%2F%2Ft9.baidu.com%2Fit%2Fu%3D583874135%2C70653437%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D3607%26h%3D2408",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              Text("右边文字")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("左边文字"),
              CachedNetworkImage(
                imageUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582469061411&di=bbe47b1cfdc4c7281a73935c42acda59&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D1484500186%2C1503043093%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D853",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              Text("右边文字")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("左边文字"),
              CachedNetworkImage(
                imageUrl:  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582469061411&di=d54cfb8d3804a21efd56f6892d91a40e&imgtype=0&src=http%3A%2F%2Ft7.baidu.com%2Fit%2Fu%3D3204887199%2C3790688592%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D4610%26h%3D2968",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              Text("右边文字")
            ],
          ),

        ],
      ),
    );
  }
}
