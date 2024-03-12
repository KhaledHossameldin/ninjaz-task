import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/themes/extensions.dart';
import '../../domain/entities/post_entity.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});

  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16.height,
          horizontal: 16.width,
        ),
        child: Column(children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: post.owner!.picture.cachedProvider,
            ),
            title: Text(
              '${post.owner!.title}. ${post.owner!.firstName} ${post.owner!.lastName}',
            ),
            subtitle: Text(timeago.format(post.publishDate)),
          ),
          Row(children: [
            Expanded(
              child: ClipRRect(
                borderRadius: 8.borderRadius,
                child: AspectRatio(
                  aspectRatio: 1 / 1.2,
                  child: post.image.cachedNetworkImage(),
                ),
              ),
            ),
            16.emptyWidth,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.text),
                  4.emptyHeight,
                  Wrap(
                    spacing: 12.width,
                    children:
                        post.tags.map((e) => Chip(label: Text(e))).toList(),
                  ),
                  8.emptyHeight,
                  Row(children: [
                    const Icon(Icons.thumb_up_rounded, size: 20),
                    8.emptyWidth,
                    Text(post.likes.toString()),
                  ]),
                ],
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
