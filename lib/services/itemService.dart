import 'package:dio/dio.dart';

class itemService {
  final Dio _dio;
  final String _token;

  itemService(this._dio, this._token);

  Future<List<Map<String, dynamic>>> getItemService() async {
    try {
      final response = await _dio.get(
        "https://60e2-202-126-91-135.ngrok-free.app/auth/items",
        options: Options(
          headers: {
            'Authorization': 'Bearer $_token',
            'Accept': 'application/json',
          },
        ),
      );

      // Debug print the full response
      print("This is items service: ${response.data}");

      // Assuming the response data is a list of maps
      if (response.data is List) {
        // Convert each item in the list to a map
        List<Map<String, dynamic>> itemList = [];
        for (var item in response.data) {
          if (item is Map<String, dynamic>) {
            itemList.add(item);
          }
        }
        return itemList;
      } else {
        // If for any reason, the data is not a list, log and throw an error or return an empty list
        print('Data is not a list');
        return [];
      }
    } catch (error) {
      print('Failed to fetch items service: $error');
      throw error;
    }
  }
}
