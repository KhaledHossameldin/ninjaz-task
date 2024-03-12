import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../home_screen.dart';
import '../posts/presentation/pages/posts_screen.dart';
import 'routes.dart';

class AppRouter {
  final _routes = GetIt.instance.get<Routes>();
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  late final router = GoRouter(
    initialLocation: _routes.home,
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => HomeScreen(child: child),
        routes: [
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: _routes.home,
            builder: (context, state) => const PostsScreen(),
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: _routes.tab2,
            builder: (context, state) => const Center(
              child: Text('Coming Soon...'),
            ),
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: _routes.tab3,
            builder: (context, state) => const Center(
              child: Text('Coming Soon...'),
            ),
          ),
        ],
      ),
    ],
  );
}
