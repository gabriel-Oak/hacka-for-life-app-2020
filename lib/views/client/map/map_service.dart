import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sweet_corn_app/constraints.dart';

class MapService {
  final dio = Dio(BaseOptions(
    receiveTimeout: 5000,
    sendTimeout: 5000,
  ));

  Future<List> getNearbyStores(
      {@required Position userLocation, String search}) async {
    dynamic res;
    try {
      res = (await dio.get(
        '$kApi/store/proximity/${userLocation.latitude}/${userLocation.longitude}',
        queryParameters: {'q': search},
      ))
          .data;
      return res;
    } on DioError {
      throw kMessageDioError;
    } catch (e) {
      print(e);
      throw kMessageServerError;
    }
  }
}
