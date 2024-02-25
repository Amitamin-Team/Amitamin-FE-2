import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:amitamin_frontend/common/common.dart';
import 'register_navigationbar.dart';

class RegisterSecondScreen extends ConsumerStatefulWidget {
  const RegisterSecondScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterSecondScreen> createState() =>
      RegisterSecondScreenState();
}

class RegisterSecondScreenState extends ConsumerState<RegisterSecondScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '회원가입',
        leadingDisable: true,
        actionDisable: false,
        actionOnPressed: () => context.replace('/login_screen'),
      ),
      bottomNavigationBar: RegisterBottomNavigationBar(
        backOnTap: () => context.pop(),
        text: "2 / 3",
        nextOnTap: () => context.goNamed('register_third_screen'),
      ),
      child: WillPopScope(
        onWillPop: () async {
          context.replace('/login_screen');
          return false;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "이메일",
                    style: CustomText.body3,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: OutlinedInput(
                          onChanged: (String email) {},
                          hintText: '이메일을 입력하세요',
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: BlueTextButton(
                          onPressed: () {
                            // TODO : 인증하기 로직 추가
                          },
                          text: "인증하기",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    "비밀번호",
                    style: CustomText.body3,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  OutlinedInput(
                    onChanged: (String pwd) {},
                    hintText: '비밀번호를 입력하세요',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    "비밀번호 확인",
                    style: CustomText.body3,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  OutlinedInput(
                    onChanged: (String pwd) {},
                    hintText: '비밀번호를 한 번 더 입력하세요',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
