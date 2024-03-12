import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../utils/error_handler.dart';
import '../../models/post/post.dart';

class PostsRemoteDataSource {
  Future<Either<String, List<Post>>> getPosts({
    required int page,
    int limit = 20,
  }) async {
    try {
      final response = await http.get(
        Uri.https(
          dotenv.env['DOMAIN']!,
          '${dotenv.env['API_PATH']!}/post',
          {'page': '$page', 'limit': '$limit'},
        ),
        headers: {'app-id': dotenv.env['APP_ID']!},
      );
      final data = ResponseHandler.getResponseBody(response);
      Logger().d(data);
      final posts = (data['data'] as List<dynamic>)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(posts);
    } catch (e) {
      final error = ResponseHandler.getExceptionString(e as Exception);
      Logger().e(error);
      return Left(error);
    }
  }
}
