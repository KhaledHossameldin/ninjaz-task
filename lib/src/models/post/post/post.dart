import 'package:freezed_annotation/freezed_annotation.dart';

import '../owner/owner.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required String id,
    required String image,
    required int likes,
    required List<String> tags,
    required String text,
    required DateTime publishDate,
    required Owner owner,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
