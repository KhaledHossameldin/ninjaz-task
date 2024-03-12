import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/post_entity.dart';
import '../owner/owner.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const Post._();

  const factory Post({
    required String id,
    required String image,
    required int likes,
    required String text,
    required DateTime publishDate,
    required Owner owner,
    required List<String> tags,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  PostEntity toEntity() => PostEntity(id, image, likes, text, publishDate,
      owner: owner.toEntity(), tags: tags);
}
