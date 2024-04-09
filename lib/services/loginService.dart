import 'package:dio/dio.dart';

class LoginService {
  final Dio _dio;

  LoginService(this._dio);

  Future<String> login(String username, String password) async {
    try {
      final response = await _dio.post(
        "https://7080-202-131-242-131.ngrok-free.app/auth/login",
        data: {
          "username": username,
          "password": password,
        },
      );

      // Check if the response contains a token
      if (response.data['token'] != null) {
        final token = response.data['token'] as String;
        final formattedToken = token;
        return formattedToken;
      } else {
        // Handle the case where the response doesn't contain a valid token
        print("Login failed: Invalid response format");
        throw DioError(
          requestOptions: response.requestOptions,
          error: "Invalid response format",
        );
      }
    } catch (error) {
      // Handle other errors
      print("Login failed: $error");
      throw error;
    }
  }
}
