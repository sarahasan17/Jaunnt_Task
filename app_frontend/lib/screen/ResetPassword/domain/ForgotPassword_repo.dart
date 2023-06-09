import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../constant/errors/Failure.dart';
import '../../../constant/networktool.dart';
import '../../../url_contants.dart';

class ForgotPasswordResponse {
  final String? message;

  ForgotPasswordResponse({
    this.message,
  });

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?;

  Map<String, dynamic> toJson() => {'message': message};
}

class ForgotPasswordRepo {
  final Dio _dio = Dio();
  final NetworkTool _networkInfo = NetworkInfoImpl();
  Future<Either<Failure, ForgotPasswordResponse>> forgotpassword(
      String phoneNumber) async {
    String request =
        "https://jaunnt-app-production.up.railway.app/auth/forgotpassword";

    if (await _networkInfo.isConnected()) {
      try {
        final Response response = await _dio.post(request,
            data: jsonEncode({'phoneNumber': phoneNumber}),
            options: Options(
              headers: {
                HttpHeaders.authorizationHeader: "Bearer $token",
              },
            ));
        var body = response.data as Map<String, dynamic>;
        switch (response.statusCode) {
          case 200:
            return Right(ForgotPasswordResponse.fromJson(body));
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
