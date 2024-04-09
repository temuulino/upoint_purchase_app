import 'package:dio/dio.dart';

class LoginService {
  final Dio _dio;

  LoginService(this._dio);

  Future<String> login(String username, String password) async {
    try {
      final response = await _dio.post(
        "https://05f2-202-126-91-135.ngrok-free.app/auth/login",
        options: Options(
          headers: {
            // 'Authorization': 'Bearer $_token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
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
      if (error is DioError) {
        // This will print the status code and the response body.
        print("Dio error: ${error.response?.statusCode} - ${error.response?.data}");
      }
      print("Login failed: $error");
      throw error;
    }
  }
}
