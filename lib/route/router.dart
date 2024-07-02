import 'package:amitamin_frontend/screens/my/my_profile_screen.dart';
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
      name: 'login_screen',
      builder: (context, state) => LoginScreen(),
      routes: [
        GoRoute(
          path: 'password_find_screen',
          name: 'password_find_screen',
          builder: (context, state) => PasswordFindScreen()
        )
      ]
    ),
    ShellRoute(
      builder: (context, state, child) => RootScreen(child: child),
      routes: [
        GoRoute(
          path: '/home_screen',
          name: 'home_screen',
          builder: (context, state) => HomeScreen(),
          routes: [],
        ),
        GoRoute(
          path: '/analysis_screen',
          name: 'analysis_screen',
          builder: (context, state) => AnalysisScreen(),
        ),
        GoRoute(
          path: '/my_screen',
          name: 'my_screen',
          builder: (context, state) => MyScreen(),
          routes: [
            GoRoute(
              path: 'my_profile_screen',
              name: 'my_profile_screen',
              builder: (context, state) => MyProfileScreen(),
            ),
          ],
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
    GoRoute(
      path: '/home_fatigue_screen',
      name: 'home_fatigue_screen',
      builder: (context, state) => HomeFatigueScreen(),
    ),
    GoRoute(
      path: '/home_select_survey_screen',
      name: 'home_select_survey_screen',
      builder: (context, state) => HomeSelectSurveyScreen(),
      routes: [],
    ),
  ],
);
