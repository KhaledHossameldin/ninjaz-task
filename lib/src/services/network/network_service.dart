import '../../models/post/post/post.dart';
import 'handlers.dart';

class NetworkService {
  final _handlers = NetworkHandlers();

  Future<List<Post>> getPosts({required int page, required int limit}) async {
    final response = await _handlers.get('post', params: {
      'page': '$page',
      'limit': '$limit',
    });
    return response['data'].map<Post>((e) => Post.fromJson(e)).toList();
  }
}
