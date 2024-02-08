// ignore_for_file: use_build_context_synchronously

import 'package:amitamin_frontend/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 2000), () {
      checkAuth();
    });
  }

  void checkAuth() async {
    final storage = ref.watch(secureStorageProvider);

    final autoLoginYN = await storage.read(key: ProjectConstant.AUTO_LOGIN_YN);

    // 자동로그인 설정이 없을 경우 로그인 화면으로 이동
    if(autoLoginYN == null || autoLoginYN == 'N') {
      context.go('/login_screen');
    } else {
      final accessToken = await storage.read(key: ProjectConstant.ACCESS_TOKEN);
      final refreshToken = await storage.read(key: ProjectConstant.REFRESH_TOKEN);

      // 토큰이 없을 경우 로그인 화면으로 이동
      if(accessToken == null && refreshToken == null) {
        context.go('/login_screen');
      } else {
        // 토큰이 있을 경우 홈 화면으로 이동
        // context.go('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/app_logo.svg",
            ),
            const SizedBox(
              height: 16.0,
            ),
            const CircularProgressIndicator(
              color: CustomColor.primaryBlue100,
            )
          ],
        ),
      ),
    );
  }
}