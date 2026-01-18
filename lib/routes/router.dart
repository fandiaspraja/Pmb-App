import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:pmb_app/features/auth/presentation/pages/login_page.dart';
import 'package:pmb_app/features/splash/presentation/pages/splash_page.dart';
import 'package:pmb_app/features/student/presentation/pages/detail_page.dart';
import 'package:pmb_app/features/student/presentation/pages/home_page.dart';
import 'package:pmb_app/features/student/presentation/pages/register_page.dart';

Page<dynamic> buildPageWithTransition(Widget child, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.2), // Mulai dari bawah sedikit
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      );
    },
  );
}

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  observers: [ChuckerFlutter.navigatorObserver],
  routes: [
    GoRoute(
      path: '/splash',
      pageBuilder: (context, state) =>
          buildPageWithTransition(SplashPage(), state),
    ),

    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return buildPageWithTransition(LoginPage(), state);
      },
    ),

    GoRoute(
      path: '/home',
      pageBuilder: (context, state) {
        return buildPageWithTransition(HomePage(), state);
      },
    ),

    GoRoute(
      path: '/detail',
      pageBuilder: (context, state) {
        int id = state.extra as int;

        return buildPageWithTransition(DetailPage(id: id), state);
      },
    ),
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) {
        return buildPageWithTransition(RegisterPage(), state);
      },
    ),
  ],
);
