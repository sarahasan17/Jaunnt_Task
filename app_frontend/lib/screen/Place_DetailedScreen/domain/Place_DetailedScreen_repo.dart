import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/errors/Failure.dart';
import '../../../constant/network_info.dart';
import '../../../constant/sharedpref_keys.dart';
import '../../../url_contants.dart';
import '../data/Place_Detailedscreen_response.dart';

class Place_DetailedScreenRepo {
  final Dio _dio = Dio();
  final NetworkInfoImpl _networkInfo = NetworkInfoImpl();

  Future<Either<Failure, Place_DetailedResponse>> getProfile() async {
    String token;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //token = _prefs.getString(TOKEN_KEY) ?? "";
    token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0NTlmNGFhMWUyODhkMzc3NTkwYzY0NyIsInJvbGUiOiJBRE1JTiIsImlhdCI6MTY4NjA1MjEwOSwiZXhwIjoxNjg2NjU2OTA5fQ.447NjA-0sMKMDKWUukyhAdm2B6yKJUI0ASkViEnw1Xk";
    String url = getplace + "6438083e57420d8c86804f1f";

    if (await _networkInfo.isConnected()) {
      try {
        final Response response = await _dio.get(url,
            options: Options(
              headers: {
                HttpHeaders.authorizationHeader: "Bearer $token",
              },
            ));

        var body = response.data as Map<String, dynamic>;
        switch (response.statusCode) {
          case 200:
            return Right(Place_DetailedResponse.fromJson(body));

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
