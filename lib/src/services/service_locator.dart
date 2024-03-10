import 'package:get_it/get_it.dart';
import 'package:ninjaz_task/routes/app_router.dart';
import 'package:ninjaz_task/routes/routes.dart';
import 'package:ninjaz_task/src/themes/app_theme.dart';

class ServiceLocator {
  const ServiceLocator._();

  static final _getIt = GetIt.instance;

  static void init() {
    _getIt.registerSingleton<AppTheme>(AppTheme());
    _getIt.registerSingleton<Routes>(Routes());
    _getIt.registerSingleton<AppRouter>(AppRouter());
  }
}
