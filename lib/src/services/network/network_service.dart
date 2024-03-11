import '../../models/post/post/post.dart';
import 'handlers.dart';

class NetworkService {
  final _handlers = NetworkHandlers();

  Future<List<Post>> getPosts() async {
    final response = await _handlers.get('post');
    return response['data'].map<Post>((e) => Post.fromJson(e)).toList();
  }
}
