import 'package:cyberpunkphoto/global/themes.dart';
import 'package:cyberpunkphoto/pages/cyberpunk/index.dart';
import 'package:cyberpunkphoto/services/global_service_center.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '假的会员购',
      theme: GlobalTheme.buildTheme(),
      home: CyberpunkFuture(),
      routes: RouterService.baseRoute,
      navigatorObservers: [routeObserver],
    );
  }

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((duration){
      RouterService();
      RouterService.rootContext = context;
    });
  }


}
