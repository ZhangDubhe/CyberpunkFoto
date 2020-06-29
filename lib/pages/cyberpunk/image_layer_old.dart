import 'dart:ui';

import 'package:cyberpunkphoto/pages/cyberpunk/cyberpunk_model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

/// for network image
class ImageLayerOld extends StatefulWidget {
  BehaviorSubject<bool> isFilterOn = BehaviorSubject.seeded(true);
  String url;

  ImageLayerOld({
    this.isFilterOn,
    this.url
  });

  @override
  _ImageLayerOldState createState() => _ImageLayerOldState();
}

class _ImageLayerOldState extends State<ImageLayerOld> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.isFilterOn,
      initialData: true,
      builder: (context, snapshot) {
        return Center(
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                color: Colors.white10,
              ),
              _imageBuilder(),

            ] + _filters(snapshot.data),
          ),
        );
      }
    );
  }

  List<Widget> _filters(bool isShow) {
    if (isShow) {
      return [
        _imageBuilder(cFilter: CyberpunkFilter(
            color: Colors.red,
            opacity: 0.6,
            offset: Offset(-2, 2)
        )),
        _imageBuilder(cFilter: CyberpunkFilter(
            color: Colors.blue,
            opacity: 0.6,
            blurSigma: Offset(200, 40),
            offset: Offset(2, -2)
        )),
//        _imageBuilder(cFilter: CyberpunkFilter(
//            color: Colors.green,
//            opacity: 0.6
//        )),
        _imageBuilder(cFilter: CyberpunkFilter(
            color: Colors.white10,
            blendMode: BlendMode.darken,
            opacity: 0.6
        )),
      ];
    } else {
      return [];
    }
  }
  Widget _imageBuilder({double height: 400, CyberpunkFilter cFilter}) {
    return Positioned(
      top: cFilter?.offset?.dy??0,
      left: cFilter?.offset?.dx??0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: cFilter?.blurSigma?.dx??0,
              sigmaY: cFilter?.blurSigma?.dy??0
          ),
          child: Opacity(
            opacity: cFilter?.opacity??1,
            child: Container(
                height: height,
                child: Image.network(widget.url,
                  color: cFilter?.color,
                  colorBlendMode: cFilter?.blendMode??BlendMode.color,
                )
            ),
          ),
        ),
      ),
    );
  }

}
