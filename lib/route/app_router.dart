import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/home/main_screen.dart';
import '../views/onboarding/onboarding_screen.dart';

class AppRoute {
  static GoRouter router(bool showOnboarding) => GoRouter(
        initialLocation: showOnboarding ? '/onboarding' : '/',
        routes: [
          GoRoute(
            path: '/onboarding',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: PetsOnBoardingScreen(),
              transitionsBuilder: (context, animation, _, child) =>
                  FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            path: '/',
            builder: (context, state) => const MainScreen(),
          ),
        ],
      );
}

