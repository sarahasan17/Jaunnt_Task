import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant/errors/Failure.dart';
import '../../../../constant/network_info.dart';
import '../../../../constant/sharedpref_keys.dart';
import '../../../../url_contants.dart';

class BookmarkRepo {
  final Dio _dio = Dio();
  final NetworkInfoImpl _networkInfo = NetworkInfoImpl();

  Future<Either<Failure, String>> bookmark() async {
    //String token;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //token = _prefs.getString(TOKEN_KEY) ?? "";
    String url =
        "https://jaunnt-app-production.up.railway.app/places/bookmark/6438083e57420d8c86804f1f";

    if (await _networkInfo.isConnected()) {
      try {
        final Response response = await _dio.put(url,
            options: Options(
              headers: {
                HttpHeaders.authorizationHeader: "Bearer $token",
              },
            ));

        var body = response.data as Map<String, dynamic>;
        switch (response.statusCode) {
          case 200:
            return Right(body as String);
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
