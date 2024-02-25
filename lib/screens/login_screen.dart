import 'package:amitamin_frontend/common/common.dart';
import 'package:amitamin_frontend/common/utils/fn_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      child: WillPopScope(
        onWillPop: () async {
          fnClose();
          return false;
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/app_logo.svg",
                  width: 140,
                  height: 177,
                ),
                const SizedBox(
                  height: 40,
                ),
                OutlinedInput(
                  onChanged: (String email) {},
                  hintText: '이메일을 입력하세요',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                OutlinedInput(
                  onChanged: (String pwd) {},
                  hintText: '비밀번호를 입력하세요',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 22,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // TODO : secure_storage 값 저장 로직 추가
                      },
                      child: SvgPicture.asset(
                        "assets/icons/radio_unchecked.svg",
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text('자동로그인', style: CustomText.body6),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                BlueTextButton(
                  onPressed: () {
                    // TODO : 로그인 로직 추가
                    context.go('/home_screen');
                  },
                  text: '로그인',
                ),
                const SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        // TODO : 회원가입 화면 이동

                        context.goNamed('register_first_screen');
                      },
                      child: Text(
                        "회원가입",
                        style: TextStyle(
                            fontSize: CustomText.body7.fontSize,
                            fontWeight: CustomText.body7.fontWeight,
                            fontFamily: CustomText.body7.fontFamily,
                            color: CustomColor.extraDarkGray),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // TODO : 비밀번호 찾기 화면 이동
                      },
                      child: Text(
                        "비밀번호 찾기",
                        style: TextStyle(
                            fontSize: CustomText.body7.fontSize,
                            fontWeight: CustomText.body7.fontWeight,
                            fontFamily: CustomText.body7.fontFamily,
                            color: CustomColor.extraDarkGray),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
