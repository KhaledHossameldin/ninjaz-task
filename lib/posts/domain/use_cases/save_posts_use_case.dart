import '../entities/post_entity.dart';
import '../repositories/posts_repository.dart';

class SavePostsUseCase implements ISavePostsUseCase {
  final PostsRepository _repository;
  SavePostsUseCase(this._repository);

  @override
  void call({required List<PostEntity> posts}) {
    return _repository.savePosts(posts);
  }
}

abstract class ISavePostsUseCase {
  void call({required List<PostEntity> posts});
}
