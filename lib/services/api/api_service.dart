import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_chat/core/utils/constant.dart';

class ApiService {
  static final Dio _dio = Dio();

   Future<Either<String, dynamic>> login(
      String username, String password) async {
    try {
      final response = await _dio.post(
        AppConstant.login,
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        // Parse response using model (if applicable)
        // final loginResponse = LoginResponse.fromJson(response.data);
        // return Right(loginResponse);

        return Right(response.data); // Return raw data for simplicity
      } else {
        return Left('Error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Left(
          e.message ?? 'Network Error'); // Handle specific errors if needed
    } catch (e) {
      return Left(e.toString());
    }
  }
}
