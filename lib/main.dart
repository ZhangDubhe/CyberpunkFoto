import 'package:cyberpunkphoto/global/themes.dart';
import 'package:cyberpunkphoto/services/global_service_center.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
//  LicenseRegistry.addLicense(() async* {
//    final license = await rootBundle.loadString('google_fonts/OFL.txt');
//    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
//  });
  _adjustThemeMode();
  runApp(MyApp());
}

void _adjustThemeMode() {
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.light);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}


class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cyberpunk Foto',
      themeMode: ThemeMode.dark,
      darkTheme: GlobalTheme.buildTheme(),
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
