import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'register_navigationbar.dart';

import 'package:amitamin_frontend/common/common.dart';

class RegisterFirstScreen extends ConsumerStatefulWidget {
  const RegisterFirstScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterFirstScreen> createState() =>
      RegisterFirstScreenState();
}

class RegisterFirstScreenState extends ConsumerState<RegisterFirstScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '회원가입',
        leadingDisable: true,
        actionDisable: false,
        actionOnPressed: () => context.replace('/login'),
      ),
      bottomNavigationBar: RegisterBottomNavigationBar(
        backDisable: true,
        text: "1 / 3",
        nextOnTap: () => context.go('/register_screen/register_second_screen'),
      ),
      child: WillPopScope(
        onWillPop: () async {
          context.replace('/login');
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
                    "닉네임",
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
                          hintText: '닉네임을 입력하세요',
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: BlueTextButton(
                          onPressed: () {
                            // TODO : 중복확인 로직 추가
                          },
                          text: "중복확인",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    "성별",
                    style: CustomText.body3,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: BlueTextButton(
                          onPressed: () {},
                          text: "여성",
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: BlueTextButton(
                          onPressed: () {},
                          text: "남성",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    "생년월일",
                    style: CustomText.body3,
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
