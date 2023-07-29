import 'package:dio/dio.dart';
import 'package:koifarm/API/endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:koifarm/API/koi_model.dart';

class ProductRemoteDataSource {
  late Dio _koi;

  ProductRemoteDataSource() {
    _koi = Dio(BaseOptions(
        baseUrl: Endpoints.baseUrl,
        responseType: ResponseType.json,
        headers: {
          "Content-Type": "application/json",
        }));
  }

  Future<koimodel> getAll() async {
    final response = await _koi.get(
      Endpoints.productUrl,
    );
    return koimodel.fromJson(response.data);
  }
}

final productDataSourceProvider = Provider<ProductRemoteDataSource>((ref) {
  return ProductRemoteDataSource();
});
