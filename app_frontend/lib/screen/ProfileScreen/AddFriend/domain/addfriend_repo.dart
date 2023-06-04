import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../constant/errors/Failure.dart';
import '../../../../constant/network_info.dart';

class AddFriendRepo {
  final Dio _dio = Dio();
  final NetworkInfoImpl _networkInfo = NetworkInfoImpl();
  Future<Either<Failure, Map<String, dynamic>>> addfriend(String id) async {
    String url = "";

    if (await _networkInfo.isConnected()) {
      try {
        final Response response = await _dio.post(
          url,
          data: jsonEncode({"friendId": id}),
        );

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
