import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../utils/pagination.dart';
import '../models/post/post.dart';
import '../services/network/network_service.dart';
import '../services/realm_service.dart';
import 'base_state.dart';

class PostsCubit extends Cubit<BaseState> with Pagination<Post> {
  PostsCubit() : super(const InitialState()) {
    controller.addPageRequestListener(listener);
  }

  final _network = GetIt.instance<NetworkService>();
  final _realm = GetIt.instance<RealmService>();

  void listener(int page) => _fetchMore(page: page);

  Future<void> fetch() async {
    try {
      if (state is SuccessState) {
        reset(listener);
      }
      emit(const LoadingState());
      final posts = await _network.getPosts(page: 1, limit: limit);
      if (posts.isEmpty) {
        emit(const EmptyListState());
        return;
      }
      appendPage(items: posts);
      _realm.savePosts(posts, isFirstPage: true);
      emit(SuccessState(data: posts));
    } catch (e) {
      if (e == 'There is no internet connection') {
        final posts = _realm.getPosts();
        if (posts.isEmpty) {
          emit(ErrorState(message: '$e'));
          return;
        }
        appendPage(items: posts, isOffline: true);
        emit(SuccessState(data: posts));
        return;
      }
      controller.error = e;
      emit(ErrorState(message: '$e'));
    }
  }

  Future<void> _fetchMore({required int page}) async {
    try {
      final oldPosts = controller.itemList!;
      final posts = await _network.getPosts(page: page, limit: limit);
      appendPage(items: posts);
      _realm.savePosts(posts);
      controller.itemList = [...oldPosts, ...posts];
    } catch (e) {
      controller.error = e;
    }
  }
}
