import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../constant/errors/Failure.dart';
import '../../../../constant/network_info.dart';
import '../../../../url_contants.dart';

class UnFriendRepo {
  final Dio _dio = Dio();
  final NetworkInfoImpl _networkInfo = NetworkInfoImpl();
  Future<Either<Failure, Map<String, dynamic>>> unfriend(String id) async {
    String url = "https://jaunnt-app-production.up.railway.app/users/unFriend";

    if (await _networkInfo.isConnected()) {
      try {
        final Response response = await _dio.post(url,
            data: jsonEncode({"friendId": id}),
            options: Options(
              headers: {
                HttpHeaders.authorizationHeader: "Bearer $token",
              },
            ));

        var body = response.data as Map<String, dynamic>;
        switch (response.statusCode) {
          case 200:
            return Right(body);
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
