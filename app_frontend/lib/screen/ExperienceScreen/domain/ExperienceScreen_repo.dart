import 'dart:developer';
import 'dart:io';
import 'package:app_frontend/url_contants.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/errors/Failure.dart';
import '../../../constant/network_info.dart';
import '../../../constant/sharedpref_keys.dart';
import '../data/experiencescreen_response.dart';

class ExperienceScreenRepo {
  final Dio _dio = Dio();
  final NetworkInfoImpl _networkInfo = NetworkInfoImpl();

  Future<Either<Failure, ExperienceResponse>> getexp() async {
    //String token;
    //SharedPreferences _prefs = await SharedPreferences.getInstance();
    //token = _prefs.getString(TOKEN_KEY) ?? "";
    //token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MGI1MTJlMDgxNWIyZWI2MGZmYzBkOCIsImlhdCI6MTY3ODQ2MzQ3MywiZXhwIjoxNjc4NTQ5ODczfQ.Xi88oMZW3jduRg6XJyFX3-vjeB6dmTCIQJTxCExQkw8";

    String url =
        "https://jaunnt-app-production.up.railway.app/experience/64841fe59ff2e8afb1ce2cf9";

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
            return Right(ExperienceResponse.fromJson(body));

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
