import 'package:flutter/material.dart';

///图片内存检测
class ImageMemoryCheck extends StatefulWidget {
  @override
  _ImageMemoryCheckState createState() => _ImageMemoryCheckState();
}

class _ImageMemoryCheckState extends State<ImageMemoryCheck> {
  List<ImageData> _imageDataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAppImageInfo((images) {
      setState(() {
        _imageDataList = images;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片内存消耗"),
      ),
      body: _imageDataList.length == 0
          ? Center(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.directions_run,
                    size: 48,
                  ),
                  Text("没有找到图片")
                ],
              ),
            )
          : ListView.builder(
              itemBuilder: buildImageItem,
            ),
    );
  }

  void _getAppImageInfo(callBack) async {}

  Widget buildImageItem(BuildContext context, int index) {
    ImageData imageData = _imageDataList[index];
    return ListTile(
      leading: Image(
        image: imageData.imageProvider,
        width: 100,
        height: 100,
      ),
      title: Text("占用内存：${imageData.imageMemorySize}"),
      subtitle: Text("${imageData.imagePath}\n${imageData.dartFilePath}"),
    );
  }
}

class ImageData {
  ImageProvider imageProvider;
  String imagePath;
  double imageMemorySize;
  String dartFilePath;
}
