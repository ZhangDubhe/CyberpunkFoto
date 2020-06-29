import 'package:cyberpunkphoto/global/themes.dart';
import 'package:flutter/material.dart';
class BreatheLight extends StatefulWidget {
  @override
  _BreatheLightState createState() => _BreatheLightState();
}

class _BreatheLightState extends State<BreatheLight> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      child: Center(
        child: AnimatedBuilder(
          child: Center(
            child: Container(
              height: 2,
              width: 180,
              decoration: BoxDecoration(
                color: ThemeColor.kCyberPink,
                borderRadius: GlobalTheme.commonRadius(radius: 5)
              ),
            ),
          ),
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return Opacity(
              opacity: 1 * animation.value,
              child: Container(
                width: 200,
                height: 10,
                decoration: BoxDecoration(
                    boxShadow: GlobalTheme.commonShadow(
                        radius: 2,
                        opacity: 0.6,
                        offset: Offset(0, animation.value * 4),
                        color: ThemeColor.kCyberPink)
                ),
                child: child,
              ),
            );
          },
        ),
      ),
    );
  }

  Animation<double> animation;
  AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);
    animation = Tween<double>(begin: 1, end: 0.4).animate(controller)
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
