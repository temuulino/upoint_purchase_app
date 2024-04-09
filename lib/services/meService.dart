import 'package:dio/dio.dart';

class meService {
  final Dio _dio;
  final String _token;

  meService(this._dio, this._token);

  Future<Map<String, dynamic>> getMeService() async {
    try {
      final response = await _dio.get(
        "https://60e2-202-126-91-135.ngrok-free.app/auth/me",
        options: Options(
          headers: {
            'Authorization': 'Bearer $_token',
            'Accept': 'application/json',
          },
        ),
      );

      // Debug print the full response
      print("This is me service: ${response.data}");

      // Assuming the response data is already a Map<String, dynamic>
      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else {
        // If for any reason, the data is not a map, log and throw an error or return a default map
        print('Data is not a map');
        throw FormatException('Expected the data to be a map');
      }
    } catch (error) {
      print('Failed to fetch me service: $error');
      throw error;
    }
  }
}
