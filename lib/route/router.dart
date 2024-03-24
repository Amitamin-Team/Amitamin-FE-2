import 'package:amitamin_frontend/screens/screens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return router;
});

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login_screen',
      builder: (context, state) => LoginScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => RootScreen(child: child),
      routes: [
        GoRoute(
          path: '/home_screen',
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: '/analysis_screen',
          builder: (context, state) => AnalysisScreen(),
        ),
        GoRoute(
          path: '/my_screen',
          builder: (context, state) => MyScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/register_first_screen',
      name: 'register_first_screen',
      builder: (context, state) => RegisterFirstScreen(),
      routes: [
        GoRoute(
          path: 'register_second_screen',
          name: 'register_second_screen',
          builder: (context, state) => RegisterSecondScreen(),
          routes: [
            GoRoute(
              path: 'register_third_screen',
              name: 'register_third_screen',
              builder: (context, state) => RegisterThirdScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
