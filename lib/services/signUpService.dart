import 'package:dio/dio.dart';

class UpdatePasswordService {
  final Dio _dio;

  UpdatePasswordService(this._dio);

  Future<Map<String, dynamic>> updatePassword(String username, String password) async {
    try {
      final response = await _dio.post(
        "https://05f2-202-126-91-135.ngrok-free.app/auth/signup",
        options: Options(
          headers: {'accept': '*/*', 'Content-Type': 'application/json'},
        ),
        data: {'username': username, 'password': password},
      );

      print("This is signup service: $response");

      final Map<String, dynamic> signUp = Map<String, dynamic>.from(response.data);
      print("This is token $signUp");
      return signUp;
    } catch (error) {
      if (error is DioError) {
        final Map<String, dynamic> errorMessage;
        if (error.response?.statusCode == 422) {
          print('Unprocessable Entity: ${error.response?.data}');
          errorMessage = error.response?.data;
          return errorMessage;
        } else {
          print('Request failed: $error');
        }
      } else {
        print('Sign Up failed: $error');
      }
      throw error;
    }
  }
}
