import 'package:realm/realm.dart';

import '../../../domain/entities/post_entity.dart';

class PostsLocalDataSource {
  final _realm = Realm(Configuration.local([
    PostEntity.schema,
    OwnerEntity.schema,
  ]));

  void _deletePosts() {
    _realm.write(() => _realm.deleteAll<PostEntity>());
  }

  void savePosts(List<PostEntity> posts) {
    _deletePosts();
    _realm.write(() => _realm.addAll(posts));
  }

  List<PostEntity> getPosts() {
    final posts = _realm.all<PostEntity>().toList();
    return posts;
  }
}
