import 'package:get_it/get_it.dart';

import '../../routes/app_router.dart';
import '../../routes/routes.dart';
import '../cubits/posts_cubit.dart';
import 'network/network_service.dart';
import '../themes/app_theme.dart';

class ServiceLocator {
  const ServiceLocator._();

  static final _getIt = GetIt.instance;

  static void init() {
    _getIt.registerSingleton<AppTheme>(AppTheme());
    _getIt.registerSingleton<Routes>(Routes());
    _getIt.registerSingleton<AppRouter>(AppRouter());
    _getIt.registerSingleton<NetworkService>(NetworkService());
    _getIt.registerSingleton<PostsCubit>(PostsCubit());
  }
}
