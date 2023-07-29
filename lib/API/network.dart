import 'package:dio/dio.dart';
import 'package:koifarm/API/koi_model.dart';
import 'package:koifarm/API/model.dart';

class NetworkManager {
  late Dio _koi;

  String baseUrl = 'http://localhost:1337/api/kois';

  NetworkManager() {
    _koi = Dio();
  }

  Future<koimodel> getAll() async {
    final response = await _koi.get(
      "$baseUrl/",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    return koimodel.fromJson(response.data);
  }

  Future<void> addData(listkoi request) async {
    String url = '$baseUrl/';
    final response = await _koi.post(url,
        // options: Options(
        //   headers: {
        //     "Content-Type": "application/json",
        //   },
        // ),
        data: {
          'data': request.toMap(),
        });

    print(response.toString());
  }

  Future<void> updateData(int id, listkoi requestMedical) async {
    var response = await _koi.put(
      "$baseUrl/$id",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
      data: {"data": requestMedical.toMap()},
    );
    Map obj = response.data;
  }

  Future<void> deleteData(int id) async {
    var response = await Dio().delete(
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
      "$baseUrl/$id",
    );
    print(response.statusCode);
  }
}
