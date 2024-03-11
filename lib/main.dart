import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import 'routes/app_router.dart';
import 'src/services/service_locator.dart';
import 'src/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
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
      debugShowCheckedModeBanner: false,
      title: 'Ninjaz Task',
      theme: _appTheme.main,
      routerConfig: _appRouter.router,
    );
  }
}
