import 'dart:developer';
import 'dart:io';
import 'package:app_frontend/url_contants.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constant/errors/Failure.dart';
import '../../../../constant/networktool.dart';
import '../../../../constant/sharedpref_keys.dart';
import '../data/experienceofplace_response.dart';

class ExperienceOfPlaceRepo {
  final Dio _dio = Dio();
  final NetworkTool _networkInfo = NetworkInfoImpl();
  Future<Either<Failure, ExperienceOfPlaceResponse>> follower() async {
    String token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0NTlmNGFhMWUyODhkMzc3NTkwYzY0NyIsInJvbGUiOiJBRE1JTiIsImlhdCI6MTY4NTk2MzIyNSwiZXhwIjoxNjg2NTY4MDI1fQ.T1JT0yIQIebSGgWrQPuvd5HHX8LVxnkoXlTHObFQsK0";
    String request = exp_of_place + "6438083e57420d8c86804f1f";

    if (await _networkInfo.isConnected()) {
      try {
        final Response response = await _dio.get(request,
            options: Options(
              headers: {
                HttpHeaders.authorizationHeader: "Bearer ",
              },
            ));
        var body = response.data as Map<String, dynamic>;
        switch (response.statusCode) {
          case 200:
            return Right(ExperienceOfPlaceResponse.fromJson(body));
          case 404:
            return Left(UserNotFound());
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
