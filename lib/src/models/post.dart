import 'owner.dart';

class Post {
  final String id;
  final String image;
  final int likes;
  final List<String> tags;
  final String text;
  final DateTime publishDate;
  final Owner owner;

  const Post({
    required this.id,
    required this.image,
    required this.likes,
    required this.tags,
    required this.text,
    required this.publishDate,
    required this.owner,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      image: json['image'],
      likes: json['likes'],
      tags: List<String>.from(json['tags']),
      text: json['text'],
      publishDate: DateTime.parse(json['publishDate']),
      owner: Owner.fromJson(json['owner']),
    );
  }
}
