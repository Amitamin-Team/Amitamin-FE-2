// ignore_for_file: use_build_context_synchronously

import 'package:amitamin_frontend/common/common.dart';
import 'package:amitamin_frontend/data/data.dart';
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
      context.goNamed('login_screen');
    // 자동로그인 설정되어 있을 경우
    } else {
      final accessToken = await storage.read(key: ProjectConstant.ACCESS_TOKEN);
      final refreshToken = await storage.read(key: ProjectConstant.REFRESH_TOKEN);
      final expiresIn = await storage.read(key: ProjectConstant.EXPIRES_IN);
      final loginTime = await storage.read(key: ProjectConstant.LOING_TIME);

      DateTime _currentTime = DateTime.now();
      DateTime _loginTime = DateTime.parse(loginTime ?? '1970-01-01 00:00:00.000');
      int _timeDiff = _currentTime.difference(_loginTime).inSeconds;

      // 토큰이 만료되었을 경우 재요청
      try {
        if(refreshToken != null && 
           expiresIn != null && _timeDiff > int.parse(expiresIn)) {
            final response = await ref.read(authRepositoryProvider).requestRefreshRepository(
              RequestRefreshModel(
                refresh_token: refreshToken
              ),
            );

            if(response.response_code == 200) {
              ResponseRefreshModel responseRefreshModel = ResponseRefreshModel.fromJson(response.data![0]);

              await storage.write(key: ProjectConstant.ACCESS_TOKEN, value: responseRefreshModel.access_token);
              await storage.write(key: ProjectConstant.REFRESH_TOKEN, value: responseRefreshModel.refresh_token);
              await storage.write(key: ProjectConstant.EXPIRES_IN, value: responseRefreshModel.expires_in.toString());
              await storage.write(key: ProjectConstant.LOING_TIME, value: DateTime.now().toString());
            } else {
              await storage.write(key: ProjectConstant.ACCESS_TOKEN, value: null);
              await storage.write(key: ProjectConstant.REFRESH_TOKEN, value: null);
              await storage.write(key: ProjectConstant.EXPIRES_IN, value: null);
              await storage.write(key: ProjectConstant.LOING_TIME, value: null);
              await storage.write(key: ProjectConstant.AUTO_LOGIN_YN, value: null);
            }  
        }
      } catch (e) {
        await storage.write(key: ProjectConstant.ACCESS_TOKEN, value: null);
        await storage.write(key: ProjectConstant.REFRESH_TOKEN, value: null);
        await storage.write(key: ProjectConstant.EXPIRES_IN, value: null);
        await storage.write(key: ProjectConstant.LOING_TIME, value: null);
        await storage.write(key: ProjectConstant.AUTO_LOGIN_YN, value: null);
      }

      // 토큰이 없을 경우 로그인 화면으로 이동
      if(accessToken == null || refreshToken == null || expiresIn == null) {
        context.goNamed('login_screen');
      // 토큰이 있을 경우 홈 화면으로 이동
      } else {
        // TODO : 사용자 정보 불러오기

        // 홈 화면으로 이동
        context.goNamed('home_screen');
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