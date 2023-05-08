import 'dart:io';
import 'dart:developer';
import 'dart:html';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import '../../../constant/errors/Failure.dart';
import '../../../constant/network_info.dart';

class EditExperienceRepo {
  final Dio _dio = Dio();
  final NetworkInfoImpl _networkInfo = NetworkInfoImpl();
  Future<Either<Failure, Map<String, dynamic>>> editexperience(
      String files) async {
    String url = "";

    if (await _networkInfo.isConnected()) {
      try {
        FormData formData = FormData.fromMap({
          "files": await MultipartFile.fromFile(
            './upload.jpg',
            filename: files,
          ),
        });

        Response response = await _dio.post("/info", data: formData);

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
