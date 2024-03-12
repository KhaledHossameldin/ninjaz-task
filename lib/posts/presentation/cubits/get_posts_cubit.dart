import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base_state.dart';
import '../../../utils/error_handler.dart';
import '../../../utils/pagination.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/use_cases/get_posts_use_case.dart';
import '../../domain/use_cases/save_posts_use_case.dart';

class GetPostsCubit extends Cubit<BaseState> with Pagination<PostEntity> {
  GetPostsCubit(
    this._getPostsUseCase,
    this._savePostsUseCase,
  ) : super(const InitialState()) {
    controller.addPageRequestListener(listener);
  }

  final GetPostsUseCase _getPostsUseCase;
  final SavePostsUseCase _savePostsUseCase;

  void listener(int page) => _fetchMore(page: page);

  Future<void> fetch() async {
    if (state is SuccessState) reset(listener);
    emit(const LoadingState());
    final result = await _getPostsUseCase(page: 1);
    result.fold(
      (l) {
        controller.error = l;
        emit(ErrorState(message: l));
      },
      (r) async {
        if (await _loadOffline(r)) {
          return;
        }
        if (r.isEmpty) {
          emit(const EmptyListState());
          return;
        }
        appendPage(items: r);
        _savePostsUseCase(posts: r);
        emit(SuccessState(data: r));
      },
    );
  }

  Future<bool> _loadOffline(List<PostEntity> posts) async {
    final connection = await Connectivity().checkConnectivity();
    if (connection != ConnectivityResult.none) {
      return false;
    }
    if (posts.isEmpty) {
      emit(ErrorState(
        message: ResponseHandler.getExceptionString(
          const SocketException(''),
        ),
      ));
      return true;
    }
    appendPage(items: posts, isOffline: true);
    emit(SuccessState(data: posts));
    return true;
  }

  Future<void> _fetchMore({required int page}) async {
    final oldPosts = controller.itemList!;
    final result = await _getPostsUseCase(page: page);
    result.fold((l) => controller.error = l, (r) {
      appendPage(items: r);
      controller.itemList = [...oldPosts, ...r];
    });
  }
}
