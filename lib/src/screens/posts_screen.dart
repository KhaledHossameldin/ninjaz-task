import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../cubits/base_state.dart';
import '../cubits/posts_cubit.dart';
import '../models/post/owner/owner.dart';
import '../models/post/post/post.dart';
import '../themes/extensions.dart';
import '../widgets/reload_widget.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final _postsCubit = GetIt.instance<PostsCubit>();

  @override
  void initState() {
    _postsCubit.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, BaseState>(
      bloc: _postsCubit,
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ErrorState) {
          return ReloadWidget(
            text: state.message,
            onReload: () => _postsCubit.fetch(),
          );
        }
        if (state is EmptyListState) {
          return ReloadWidget(
            text: 'There are no posts right now',
            onReload: () => _postsCubit.fetch(),
          );
        }
        if (state is SuccessState<List<Post>>) {
          return RefreshIndicator(
            onRefresh: () => _postsCubit.fetch(),
            child: ListView.separated(
              itemCount: state.data.length,
              separatorBuilder: (context, index) => 4.emptyHeight,
              padding: EdgeInsets.symmetric(
                vertical: 16.height,
                horizontal: 16.width,
              ),
              itemBuilder: (context, index) {
                final post = state.data[index];
                return Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.height,
                      horizontal: 16.width,
                    ),
                    child: Column(children: [
                      _OwnerWidget(
                        owner: post.owner,
                        publishDate: post.publishDate,
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
                        Expanded(child: _Content(post: post)),
                      ]),
                    ]),
                  ),
                );
              },
            ),
          );
        }
        return const Material();
      },
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(timeago.format(post.publishDate)),
        8.emptyHeight,
        Text(post.text),
        4.emptyHeight,
        Wrap(
          spacing: 12.width,
          children: post.tags.map((e) => Chip(label: Text(e))).toList(),
        ),
        8.emptyHeight,
        Row(children: [
          const Icon(Icons.thumb_up_rounded, size: 20),
          8.emptyWidth,
          Text(post.likes.toString()),
        ]),
      ],
    );
  }
}

class _OwnerWidget extends StatelessWidget {
  const _OwnerWidget({required this.owner, required this.publishDate});

  final Owner owner;
  final DateTime publishDate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: owner.picture.cachedProvider),
      title: Text('${owner.title}. ${owner.firstName} ${owner.lastName}'),
      subtitle: Text(timeago.format(publishDate)),
    );
  }
}
