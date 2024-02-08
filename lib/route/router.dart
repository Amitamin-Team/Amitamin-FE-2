import 'package:amitamin_frontend/screens/screens.dart';
import 'package:go_router/go_router.dart';

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
    )
  ],
);