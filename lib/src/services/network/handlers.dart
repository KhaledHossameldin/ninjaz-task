import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../utils/error_handler.dart';

class NetworkHandlers {
  Map<String, String> get _headers => {'app-id': dotenv.env['APP_ID']!};

  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, String>? params,
  }) async {
    try {
      final response = await http.get(
        Uri.https(
          dotenv.env['DOMAIN']!,
          '${dotenv.env['API_PATH']!}/$url',
          params,
        ),
        headers: _headers,
      );
      final data = ResponseHandler.getResponseBody(response);
      Logger().d(data);
      return data;
    } catch (e) {
      final error = ResponseHandler.getExceptionString(e as Exception);
      Logger().e(error);
      throw error;
    }
  }
}
