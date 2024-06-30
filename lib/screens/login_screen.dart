import 'package:amitamin_frontend/common/common.dart';
import 'package:amitamin_frontend/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 자동로그인 state 값 최초 설정
    ref.read(LoginController.loginAutoCheckProvider.notifier).init();
  }

  @override
  Widget build(BuildContext context) {
    final loginButtonState = ref.watch(LoginController.loginButtonProvider);
    final loginAutoCheckState = ref.watch(LoginController.loginAutoCheckProvider);
    // final loginEmailInputState = ref.watch(LoginController.loginEmailInputProvider);
    // final loginPasswordInputState = ref.watch(LoginController.loginPasswordInputProvider);

    return DefaultLayout(
      child: WillPopScope(
        onWillPop: () async {
          fnClose();
          return false;
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
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
                      controller: emailInputController,
                      onChanged: (String email) {
                        // 이메일 인풋값 세팅
                        ref.read(LoginController.loginEmailInputProvider.notifier).set(emailInputController.text);
                      },
                      hintText: '이메일을 입력하세요',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    OutlinedInput(
                      controller: passwordInputController,
                      onChanged: (String pwd) {
                        // 로그인 버튼 활성화/비활성화
                        ref.read(LoginController.loginButtonProvider.notifier).activate(
                          emailInputController.text, passwordInputController.text);
                        // 비밀번호 인풋값 세팅
                        ref.read(LoginController.loginPasswordInputProvider.notifier).set(passwordInputController.text);
                      },
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
                            // radio button toggle 수행
                            ref.read(LoginController.loginAutoCheckProvider.notifier).toggle();
                          },
                          child: loginAutoCheckState ? SvgPicture.asset(
                            "assets/icons/check/radio_checked.svg",
                            width: 24,
                            height: 24,
                          ) : SvgPicture.asset(
                            "assets/icons/check/radio_unchecked.svg",
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
                      onPressed: () async {
          
                        await LoginController.fnLoginExecPrev(ref, context);
                        // TODO : 로그인 로직 추가
                        /*if(emailInputController.text.isEmpty) {
                          showAlertDialog(context: context, middleText: "이메일을 입력해주세요.");
                          return;
                        }
                        if(passwordInputController.text.isEmpty) {
                          showAlertDialog(context: context, middleText: "비밀번호를 입력해주세요.");
                          return;
                        }*/
            
                        // TODO : 로그인 API 연동
                        /*final result = await login(emailInputController.text, passwordInputController.text);
                        
                        if(context.mounted) {
                          if(result) {
                            context.goNamed('home_screen');
                          } else {
                            showAlertDialog(context: context, middleText: "이메일/비밀번호를 다시 확인해주세요.");
                          } 
                        }*/
            
                        // context.goNamed('home_screen');
                      },
                      text: '로그인',
                      disabled: !loginButtonState,
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
                            context.goNamed('password_find_screen');
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
        ),
      ),
    );
  }
}
