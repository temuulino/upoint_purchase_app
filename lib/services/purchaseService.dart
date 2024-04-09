import 'package:dio/dio.dart';

class purchaseService {
  final Dio _dio;
  final String _token;

  purchaseService(this._dio, this._token);

  // TODO device code оруулж ирэх
  Future<Map<String, dynamic>> doPurchase(
    String itemId,
  ) async {
    try {
      final response = await _dio.post(
        'https://60e2-202-126-91-135.ngrok-free.app/auth/purchase',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_token',
            'Accept': 'application/json',
          },
        ),
        data: {
          'itemId': itemId,
        },
      );

      print("This is purchase service: $response");

      final Map<String, dynamic> purchase = Map<String, dynamic>.from(response.data);

      return purchase;
    } catch (error) {
      print('Purchase failed: $error');
      throw error;
    }
  }
}
