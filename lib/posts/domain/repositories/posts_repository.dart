import 'package:fpdart/fpdart.dart';

import '../entities/post_entity.dart';

abstract class PostsRepository {
  Future<Either<String, List<PostEntity>>> getPosts({
    required int page,
    int limit = 20,
  });

  void savePosts(List<PostEntity> posts);
}
