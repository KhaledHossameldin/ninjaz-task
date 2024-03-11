import 'package:realm/realm.dart';

import '../models/post/post.dart';

class RealmService {
  final _realm = Realm(Configuration.local([Post.schema, Owner.schema]));

  void savePosts(List<Post> posts, {bool isFirstPage = false}) {
    if (isFirstPage) deletePosts();
    _realm.write(() => _realm.addAll(posts));
  }

  List<Post> getPosts() {
    final posts = _realm.all<Post>().toList();
    return posts;
  }

  void deletePosts() {
    _realm.write(() => _realm.deleteAll<Post>());
  }
}
