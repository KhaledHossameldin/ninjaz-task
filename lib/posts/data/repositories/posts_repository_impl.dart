import 'package:fpdart/fpdart.dart';

import '../../domain/entities/post_entity.dart';

import '../../domain/repositories/posts_repository.dart';
import '../data_source/local/posts_local_data_source.dart';
import '../data_source/remote/posts_remote_data_source.dart';

class PostsRepositoryImpl implements PostsRepository {
  PostsRepositoryImpl(this._remote, this._local);

  final PostsRemoteDataSource _remote;
  final PostsLocalDataSource _local;

  @override
  Future<Either<String, List<PostEntity>>> getPosts({
    required int page,
    int limit = 20,
  }) async {
    final result = await _remote.getPosts(page: page, limit: limit);
    return result.fold(
      (l) {
        if (l == 'There is no internet connection') {
          return right(_local.getPosts());
        }
        return left(l);
      },
      (r) => right(r.map((e) => e.toEntity()).toList()),
    );
  }

  @override
  void savePosts(List<PostEntity> posts) {
    _local.savePosts(posts);
  }
}
