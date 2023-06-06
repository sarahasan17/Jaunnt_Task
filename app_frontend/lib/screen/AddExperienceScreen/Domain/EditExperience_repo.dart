import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../constant/errors/Failure.dart';
import '../../../constant/network_info.dart';
import 'package:http/http.dart' as http;

class EditExperienceRepo {
  final Dio _dio = Dio();
  final NetworkInfoImpl _networkInfo = NetworkInfoImpl();
  Future<Either<Failure, Map<String, dynamic>>> editexperience(
      File files) async {
    String url = "http://localhost:8080/exp/640b56391e5921443408a7e9";

    if (await _networkInfo.isConnected()) {
      try {
        var request = http.MultipartRequest('PUT', Uri.parse(url));
        request.headers["Content-Type"] = 'multipart/form-data';
        request.files.add(
          http.MultipartFile.fromBytes("files", (await files.readAsBytes()),
              filename: 'git commits.jpg'),
        );

        http.StreamedResponse response = await request.send();

        switch (response.statusCode) {
          case 200:
            return Right(json.decode(await response.stream.bytesToString()));
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
