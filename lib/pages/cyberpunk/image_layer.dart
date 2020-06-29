import 'dart:io';

import 'package:cyberpunkphoto/global/themes.dart';
import 'package:cyberpunkphoto/pages/cyberpunk/custom_filters.dart';
import 'package:cyberpunkphoto/pages/cyberpunk/default_preview.dart';
import 'package:cyberpunkphoto/pages/cyberpunk/filter_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imageLib;
import 'package:path_provider/path_provider.dart';
import 'package:photofilters/photofilters.dart';

class ImageLayer extends StatefulWidget {
  imageLib.Image image;
  String filename;
  FilterViewModel viewModel;
  ImageLayer({
    this.image,
    this.filename = 'test_1.jpg',
    this.viewModel
  });

  @override
  _ImageLayerState createState() => _ImageLayerState();
}

class _ImageLayerState extends State<ImageLayer> {
  Filter filter = NoFilter();
  List<int> cacheFilter;
  @override
  Widget build(BuildContext context) {
    return widget.image == null ? DefaultPreview() : Container(
        alignment: Alignment(0.0, 0.0),
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          color: Colors.black,
          border: GlobalTheme.commonBorder(color: ThemeColor.kCyberPink.withOpacity(0.4)),
        ),
        child: FutureBuilder<List<int>>(
        future: compute(applyFilter, <String, dynamic>{
          "filter": filter,
          "image": widget.image,
          "filename": widget.filename,
        }),
        builder: (widget, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasError || snapshot.data == null) {
                print(snapshot.error);
                return Text('Error!');
              } else {
                cacheFilter = snapshot.data;
                return _imageLayer(cacheFilter);
              }
              break;
            default:
              return cacheFilter != null ? Stack(
                children: <Widget>[
                  Opacity(
                    opacity: 0.2,
                    child: _imageLayer(cacheFilter),
                  ),
                  Loading()
                ],
              ) : Loading();
          }
        },
      )
    );
  }

  Widget _imageLayer(List<int> data) {
    return Image(
        fit: BoxFit.contain,
        image: MemoryImage(
           data
        )
    );
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/cyberpunk_${widget.filename}');
  }

  Future<File> saveImage() async {
    var imageFile = await _localFile;
    await imageFile.writeAsBytes(cacheFilter);
    return imageFile;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.viewModel.hasFilter.listen((value) {
      if (value) {
        filter = CyberpunkFilter();
      } else {
        filter = NoFilter();
      }
      setState(() {

      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    cacheFilter?.clear();
    super.dispose();
  }
}


class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());;
  }
}
