import 'package:dio/dio.dart';

class DioService {
  static DioService shared = DioService();

  Dio _dioFire = Dio();

  Future get(url, {query}) {
    return _dioFire.get(url, queryParameters: query);
  }

  Future post(url, {query}) {
    return _dioFire.post(url, queryParameters: query);
  }
}