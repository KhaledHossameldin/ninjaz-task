import 'package:realm/realm.dart';

part 'post.g.dart';

@RealmModel()
class _Post {
  @PrimaryKey()
  late String id;
  late String image;
  late int likes;
  late List<String> tags;
  late String text;
  late DateTime publishDate;
  late _Owner? owner;
}

extension PostJ on Post {
  static Post toRealmObject(_Post post) {
    return Post(
      post.id,
      post.image,
      post.likes,
      post.text,
      post.publishDate,
      owner: OwnerJ.toRealmObject(post.owner!),
      tags: post.tags,
    );
  }

  static Post fromJson(Map<String, dynamic> json) {
    return toRealmObject(Post(
      json['id'] as String,
      json['image'] as String,
      json['likes'] as int,
      json['text'] as String,
      DateTime.parse(json['publishDate'] as String),
      owner: OwnerJ.fromJson(json['owner'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    ));
  }
}

@RealmModel()
class _Owner {
  late String id;
  late String title;
  late String firstName;
  late String lastName;
  late String picture;
}

extension OwnerJ on Owner {
  static Owner toRealmObject(_Owner owner) {
    return Owner(
      owner.id,
      owner.title,
      owner.firstName,
      owner.lastName,
      owner.picture,
    );
  }

  static Owner fromJson(Map<String, dynamic> json) {
    return toRealmObject(Owner(
      json['id'] as String,
      json['title'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['picture'] as String,
    ));
  }
}
