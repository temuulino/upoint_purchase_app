import 'package:dio/dio.dart';

class itemService {
  final Dio _dio;
  final String _token;

  itemService(this._dio, this._token);

  Future<Map<String, dynamic>> getItemService() async {
    try {
      final response = await _dio.get(
        "https://9a60-202-131-242-131.ngrok-free.app/auth/items",
        options: Options(
          headers: {
            'Authorization': 'Bearer $_token',
            'Accept': 'application/json',
          },
        ),
      );

      // Debug print the full response
      print("This is items service: ${response.data}");

      // Assuming the response data is already a Map<String, dynamic>
      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else {
        // If for any reason, the data is not a map, log and throw an error or return a default map
        print('Data is not a map');
        throw FormatException('Expected the data to be a map');
      }
    } catch (error) {
      print('Failed to fetch items service: $error');
      throw error;
    }
  }
}
