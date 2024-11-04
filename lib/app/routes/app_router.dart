import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zulit/app/view/app_view.dart';
import 'package:zulit/selecter/theme/views/theme_view.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRouter {
  GoRouter get router => GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, c) {
              return Scaffold();
            },
          ),
          GoRoute(
            path:  '/details',
            builder: (context, c) {
              return Scaffold();
            },
          ),
        ],
      );
}
