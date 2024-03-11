import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../services/network/network_service.dart';
import 'base_state.dart';

class PostsCubit extends Cubit<BaseState> {
  PostsCubit() : super(const InitialState());

  final _network = GetIt.instance<NetworkService>();

  Future<void> fetch() async {
    try {
      emit(const LoadingState());
      final posts = await _network.getPosts();
      if (posts.isEmpty) {
        emit(const EmptyListState());
        return;
      }
      emit(SuccessState(data: posts));
    } catch (e) {
      emit(ErrorState(message: '$e'));
    }
  }
}
