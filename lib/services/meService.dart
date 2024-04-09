import 'package:dio/dio.dart';

class meService {
  final Dio _dio;
  final String _token;

  meService(this._dio, this._token);
  Future<Map<String, dynamic>> getMeService() async {
    try {
      final response = await _dio.get(
        "https://7080-202-131-242-131.ngrok-free.app/auth/me",
        options: Options(
          headers: {
            'Authorization': 'Bearer $_token',
          },
        ),
      );

      print("This is me service: $response");

      // Check if 'data' is a map
      if (response.data['data'] is Map<String, dynamic>) {
        final Map<String, dynamic> meInfo = response.data['data'] as Map<String, dynamic>;
        return meInfo;
      } else {
        // If 'data' is not a map, handle accordingly
        print('Data is not a map');
        return {};
      }
    } catch (error) {
      print('Failed to fetch me service: $error');
      throw error;
    }
  }
}
