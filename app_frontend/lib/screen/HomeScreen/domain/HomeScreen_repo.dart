import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/errors/Failure.dart';
import '../../../constant/network_info.dart';
import '../../../constant/sharedpref_keys.dart';
import '../../../url_contants.dart';
import '../data/homescreen_response.dart';

class HomeScreenRepo {
  final Dio _dio = Dio();
  final NetworkInfoImpl _networkInfo = NetworkInfoImpl();

  Future<Either<Failure, HomeResponse>> home() async {
    //String token;
    //SharedPreferences _prefs = await SharedPreferences.getInstance();
    //token = _prefs.getString(TOKEN_KEY) ?? "";
    String url =
        "https://jaunnt-app-production.up.railway.app/places/all?lat={{lat}}&lng={{lng}}&page=0&limit=20";
    if (await _networkInfo.isConnected()) {
      try {
        final Response response = await _dio.get(url,
            options: Options(
              headers: {
                HttpHeaders.authorizationHeader: "Bearer $token",
              },
            ));
        var body = response.data as List<dynamic>;
        switch (response.statusCode) {
          case 200:
            return Right(HomeResponse.fromJson(body));

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
