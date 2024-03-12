import 'package:get_it/get_it.dart';

import '../../posts/data/data_source/remote/posts_remote_data_source.dart';
import '../../posts/domain/use_cases/get_posts_use_case.dart';
import '../../posts/presentation/cubits/get_posts_cubit.dart';
import '../../routes/app_router.dart';
import '../../routes/routes.dart';
import '../posts/data/data_source/local/posts_local_data_source.dart';
import '../posts/data/repositories/posts_repository_impl.dart';
import '../posts/domain/use_cases/save_posts_use_case.dart';
import 'themes/app_theme.dart';

class ServiceLocator {
  const ServiceLocator._();

  static final _getIt = GetIt.instance;

  static void init() {
    _getIt.registerSingleton<AppTheme>(AppTheme());
    _getIt.registerSingleton<Routes>(Routes());
    _getIt.registerSingleton<AppRouter>(AppRouter());
    final remote = _getIt.registerSingleton<PostsRemoteDataSource>(
      PostsRemoteDataSource(),
    );
    final local = _getIt.registerSingleton<PostsLocalDataSource>(
      PostsLocalDataSource(),
    );
    final repository = _getIt.registerSingleton<PostsRepositoryImpl>(
      PostsRepositoryImpl(remote, local),
    );
    final getPostsUseCase = _getIt.registerSingleton<GetPostsUseCase>(
      GetPostsUseCase(repository),
    );
    final savePostsUseCase = _getIt.registerSingleton<SavePostsUseCase>(
      SavePostsUseCase(repository),
    );
    _getIt.registerSingleton<GetPostsCubit>(
      GetPostsCubit(getPostsUseCase, savePostsUseCase),
    );
  }
}
