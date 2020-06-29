import 'package:cyberpunkphoto/global/themes.dart';
import 'package:flutter/material.dart';
class DefaultPreview extends StatefulWidget {
  @override
  _DefaultPreviewState createState() => _DefaultPreviewState();
}

class _DefaultPreviewState extends State<DefaultPreview> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 400,
      color: ThemeColor.kCyberPurple.withOpacity(0.6),
      child: Stack(
        children: <Widget>[
          AnimatedBuilder(
            child: Container(
              color: Color(0x1FFFFFFF),
              width: 399,
              height: 399,
            ),
            animation: animation,
            builder: (BuildContext context, Widget child) {
              return Positioned(
                top: 0.4 * animation.value,
                left: 0.4 * animation.value,
                child: Container(
                  width: 400,
                  height: 400,
                  color:ThemeColor.kCyberYellow.withOpacity(0.2),
                  child: child,
                ),
              );
            },
          ),
          Positioned(
            top: -1,
            left: -1,
            right: 1,
            bottom: 1,
            child: Container(
              color: Color(0x9F000000),
            ),
          )
        ],
      ),
    );
  }

  Animation<double> animation;
  AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 6000), vsync: this);
    animation = Tween<double>(begin: -80, end: 50).animate(controller)
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}
