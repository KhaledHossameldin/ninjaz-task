import 'package:fpdart/fpdart.dart';

import '../entities/post_entity.dart';
import '../repositories/posts_repository.dart';

class GetPostsUseCase implements IGetPostsUseCase {
  final PostsRepository _repository;
  GetPostsUseCase(this._repository);

  @override
  Future<Either<String, List<PostEntity>>> call({
    required int page,
    int limit = 20,
  }) async {
    return await _repository.getPosts(page: page, limit: limit);
  }
}

abstract class IGetPostsUseCase {
  Future<Either<String, List<PostEntity>>> call({
    required int page,
    int limit = 20,
  });
}
