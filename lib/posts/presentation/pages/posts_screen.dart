import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../core/base_state.dart';
import '../../../core/themes/extensions.dart';
import '../../domain/entities/post_entity.dart';
import '../cubits/get_posts_cubit.dart';
import '../widgets/post_item.dart';
import '../widgets/reload_widget.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final _getPostsCubit = GetIt.instance<GetPostsCubit>();

  @override
  void initState() {
    _getPostsCubit.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPostsCubit, BaseState>(
      bloc: _getPostsCubit,
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ErrorState) {
          return ReloadWidget(
            text: state.message,
            onReload: () => _getPostsCubit.fetch(),
          );
        }
        if (state is EmptyListState) {
          return ReloadWidget(
            text: 'There are no posts right now',
            onReload: () => _getPostsCubit.fetch(),
          );
        }
        if (state is SuccessState<List<PostEntity>>) {
          return RefreshIndicator(
            onRefresh: () => _getPostsCubit.fetch(),
            child: PagedListView<int, PostEntity>(
              padding: EdgeInsets.symmetric(horizontal: 16.width),
              pagingController: _getPostsCubit.controller,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, item, index) => PostItem(post: item),
              ),
            ),
          );
        }
        return const Material();
      },
    );
  }
}
