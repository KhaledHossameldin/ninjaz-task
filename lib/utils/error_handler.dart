import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'app_exception.dart';

class ResponseHandler {
  ResponseHandler._();

  static String getExceptionString(Exception error) {
    switch (error) {
      case SocketException _:
        return 'There is no internet connection';

      case HttpException _:
        return 'An error occurred in the request';

      case FormatException _:
        return 'Invalid data format';

      case TimeoutException _:
        return 'request timeout, please try again';

      case AppException _:
        return error.message;

      default:
        return 'Unknown error occurred';
    }
  }

  static Map<String, dynamic> getResponseBody(http.Response response) {
    final body = json.decode(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok || HttpStatus.created || HttpStatus.accepted:
        return body;

      case HttpStatus.badRequest:
        throw BadRequestException(
          body['errors'][0]['errorMessage'],
          response.request!.url.toString(),
        );

      case HttpStatus.unauthorized || HttpStatus.forbidden:
        throw UnauthorizedException(
          body['errors'][0]['errorMessage'],
          response.request!.url.toString(),
        );

      case HttpStatus.notFound:
        throw NotFoundException(
          body['errors'][0]['errorMessage'],
          response.request!.url.toString(),
        );

      default:
        throw FetchDataException(
          body['errors'][0]['errorMessage'],
          response.request!.url.toString(),
        );
    }
  }
}
