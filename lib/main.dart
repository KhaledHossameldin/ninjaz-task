import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ninjaz_task/routes/app_router.dart';
import 'package:ninjaz_task/src/services/service_locator.dart';
import 'package:ninjaz_task/src/themes/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _getIt = GetIt.instance;

  late final _appRouter = _getIt<AppRouter>();
  late final _appTheme = _getIt<AppTheme>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ninjaz Task',
      theme: _appTheme.main,
      routerConfig: _appRouter.router,
    );
  }
}
