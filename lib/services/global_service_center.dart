import 'package:flutter/material.dart';

import 'package:cyberpunkphoto/services/http/dio_service.dart';
export 'package:cyberpunkphoto/services/routers/router_service.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class GlobalServiceCenter {
  // http request
  static DioService http = DioService.shared;
}