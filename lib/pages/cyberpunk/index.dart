import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';

class CyberpunkFuture extends StatefulWidget {
  String url;

  CyberpunkFuture({this.url});

  @override
  _CyberpunkFutureState createState() => _CyberpunkFutureState();
}

class _CyberpunkFutureState extends State<CyberpunkFuture> {
  String _url = 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?ixlib=rb-1.2.1&auto=format&fit=crop&w=2013&q=80';
  BehaviorSubject<bool> _filterSwitcher = BehaviorSubject.seeded(true);

  TextStyle  _textStyle;
  TextStyle  _titleStyle;

  @override
  Widget build(BuildContext context) {
    _textStyle = TextStyle(
        color: Colors.white,
        fontSize: 20,
        shadows: [
          Shadow(
            color: Colors.yellow[100],
            offset: Offset(-2, -2),
            blurRadius: 2
          )
        ]
    );
    return Scaffold(
      backgroundColor: Color(0xFF0d0d0d),
      body: StreamBuilder<bool>(
          stream: _filterSwitcher,
          initialData: true,
          builder: (context, snapshot) {
            print(snapshot.data);
            return SafeArea(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Cyberpunk You foto!',
                      style: GoogleFonts.vt323(
                      color: Colors.white,
                      fontSize: 24
                    ),),
                  ),
                  Center(
                    child: Stack(
                      overflow: Overflow.visible,
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          bottom: -100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Back now', style: _textStyle,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Switch.adaptive(
                                  onChanged: (bool _isOn) {
                                    print(_isOn);
                                    _filterSwitcher.add(_isOn);
                                  },
                                  value: snapshot.data,
                                  activeColor: Colors.blueAccent,
                                ),
                              ),
                              Text('To Future!', style: _textStyle)
                            ],
                          ),
                        ),
                        Container(
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white10,
                        ),
                        _imageBuilder(),

                      ] + _filters(snapshot.data),
                    ),
                  ),
                ],
              ),
            );
          }
      ),
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
              child: Image.network(_url,
                color: cFilter?.color,
                colorBlendMode: cFilter?.blendMode??BlendMode.color,
              )
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
  }
}

class CyberpunkFilter {
  Color color;
  BlendMode blendMode;
  double opacity;
  Offset offset;
  Offset blurSigma;

  CyberpunkFilter({
    this.color, this.blendMode, this.opacity,
     this.offset, this.blurSigma
  });
}
