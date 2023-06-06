import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/errors/Failure.dart';
import '../../../constant/network_info.dart';
import '../../../constant/sharedpref_keys.dart';
import '../data/homescreen_response.dart';
import 'package:http/http.dart' as http;

class HomeScreenRepo {
  final Dio _dio = Dio();
  final NetworkInfoImpl _networkInfo = NetworkInfoImpl();

  Future<Either<Failure, HomeResponse>> home(
      Float lat, Float long, int queryPage, int queryLimit) async {
    String token;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString(TOKEN_KEY) ?? "";
    String url = "";
    if (await _networkInfo.isConnected()) {
      try {
        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.fields.addAll({
          'lat': lat.toString(),
          'lon': long.toString(),
          'queryPage': queryPage.toString(),
          'queryLimit': queryLimit.toString()
        });
        request.headers["Content-Type"] = 'multipart/form-data';
        http.StreamedResponse response = await request.send();

        switch (response.statusCode) {
          case 200:
            return Right(json.decode(await response.stream.bytesToString()));

          default:
            return Left(UnidentifiedFailure());
        }
      } catch (e) {
        log(e.toString());
        if (e is DioError) {
          log(e.response?.data.toString() ?? '');
          switch (e.response?.statusCode) {
            case 500:
              return Left(ServerFailure());
            case 404:
              return Left(UserNotFound());
            default:
              return Left(UnidentifiedFailure());
          }
        }

        return Left(UnidentifiedFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
