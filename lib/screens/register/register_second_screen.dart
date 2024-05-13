import 'package:amitamin_frontend/data/data.dart';
import 'package:amitamin_frontend/screens/register/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController emailInputController = TextEditingController();
  TextEditingController codeInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController passwordConfirmInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailButtonState = ref.watch(emailButtonProvider);
    final emailInputState = ref.watch(emailInputProvider);
    final verificationCodeButtonState = ref.watch(verificationCodeButtonProvider);
    final verificationCodeInputState = ref.watch(verificationCodeInputProvider);
    final passwordInputState = ref.watch(passwordInputProvider);

    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '회원가입',
        leadingDisable: true,
        actionDisable: false,
        actionOnPressed: () {
          showConfirmDialog(
            context: context, 
            middleText: Sentence.registerExitQuestion, 
            onConfirm: () {
              fnInitRegisterProviders(ref, "all");
              context.replace('/login_screen');
            }
          );
        },
      ),
      bottomNavigationBar: RegisterBottomNavigationBar(
        backOnTap: () {
          fnInitRegisterProviders(ref, "2");
          context.pop();
        },
        text: "2 / 3",
        nextOnTap: () => validateConditionAndGoToThirdScreen(ref),
      ),
      child: WillPopScope(
        onWillPop: () async {
          showConfirmDialog(
            context: context, 
            middleText: Sentence.registerExitQuestion, 
            onConfirm: () {
              fnInitRegisterProviders(ref, "all");
              context.replace('/login_screen');
            }
          );
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
                  // TODO : 가로길이 넘어갈 경우 대비
                  Text(
                    "나만의 건강정보들을 안전하게 관리하기 위해 계정을 생성해주세요.",
                    style: TextStyle(
                      fontFamily: CustomText.body7.fontFamily,
                      fontWeight: CustomText.body7.fontWeight,
                      fontSize: CustomText.body7.fontSize,
                      color: CustomColor.extraDarkGray,
                    ),
                  ),
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
                          controller: emailInputController,
                          onChanged: (String email) {
                            ref.read(emailButtonProvider.notifier).activate(
                              emailInputController.text
                            );
                          },
                          hintText: '이메일을 입력하세요',
                          keyboardType: TextInputType.emailAddress,
                          enabledBorder: (ref.read(emailInputProvider.notifier).getValidBoolState() &&
                                          emailInputState != "already_certified")?
                                            CustomColor.error :
                                            CustomColor.lightGray,
                          focusedBorder: (ref.read(emailInputProvider.notifier).getValidBoolState() &&
                                          emailInputState != "already_certified") ?
                                            CustomColor.error :
                                            CustomColor.primaryBlue100,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: BlueTextButton(
                          onPressed: () {
                            // 유효성 검증
                            String verifyEmailInputResult = ref.watch(emailInputProvider.notifier).validate(
                              emailInputController.text
                            );
                            
                            if(verifyEmailInputResult == "pass_valid") {
                              // TODO : 인증하기 로직 추가

                              // toast 메시지
                              messageToast(context, "인증번호를 메일로 보냈어요");
                            }
                          },
                          text: "인증하기",
                          disabled: !emailButtonState,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: ref.read(emailInputProvider.notifier).getValidBoolState(),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          emailInputState == "no_data" ?
                          "이메일을 입력해주세요" :
                          emailInputState == "invalid_format" ?
                          "올바른 이메일 형식이 아닙니다" :
                          emailInputState == "already_certified" ?
                          "이미 인증된 이메일입니다" :
                          "",
                          style: TextStyle(
                            fontFamily: CustomText.body7.fontFamily,
                            fontWeight: CustomText.body7.fontWeight,
                            fontSize: CustomText.body7.fontSize,
                            color: CustomColor.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: ref.watch(emailInputProvider.notifier).getVisibleCodeContentState(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          "인증번호",
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
                                controller: codeInputController,
                                onChanged: (String email) {
                                  ref.read(verificationCodeButtonProvider.notifier).activate(
                                    codeInputController.text 
                                  );
                                },
                                hintText: '인증번호를 입력하세요',
                                keyboardType: TextInputType.emailAddress,
                                inputFormatter: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                enabledBorder: ref.read(verificationCodeInputProvider.notifier).getValidBoolState() ?
                                                  CustomColor.error :
                                                  CustomColor.lightGray,
                                focusedBorder: ref.read(verificationCodeInputProvider.notifier).getValidBoolState() ?
                                                  CustomColor.error :
                                                  CustomColor.primaryBlue100,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: BlueTextButton(
                                onPressed: () {
                                  String verifyCodeInputResult = ref.read(verificationCodeInputProvider.notifier).validate(
                                    codeInputController.text
                                  );

                                  if(verifyCodeInputResult == "pass_valid") {
                                    // TODO : 인증번호 확인 로직 추가, 확인 완료 시 : pass_all 세팅
                                  }
                                },
                                text: "인증확인",
                                disabled: !verificationCodeButtonState,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: ref.read(verificationCodeInputProvider.notifier).getValidBoolState(),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          verificationCodeInputState == "no_data" ?
                          "인증번호를 입력해주세요" :
                          verificationCodeInputState == "invalid_code" ?
                          "인증번호가 맞지 않아요" :
                          "",
                          style: TextStyle(
                            fontFamily: CustomText.body7.fontFamily,
                            fontWeight: CustomText.body7.fontWeight,
                            fontSize: CustomText.body7.fontSize,
                            color: CustomColor.error,
                          ),
                        ),
                      ],
                    ),
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
                    controller: passwordInputController,
                    onChanged: (String pwd) {},
                    hintText: '비밀번호를 입력하세요',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    enabledBorder: ref.read(passwordInputProvider.notifier).getValidBoolState() ? 
                                    CustomColor.error : 
                                    CustomColor.lightGray,
                    focusedBorder: ref.read(passwordInputProvider.notifier).getValidBoolState() ? 
                                    CustomColor.error : 
                                    CustomColor.primaryBlue100,
                  ),
                  Visibility(
                    visible: ref.read(passwordInputProvider.notifier).getValidBoolState() ? true : false,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          passwordInputState == "no_data" ?
                          "비밀번호를 입력해주세요" :
                          passwordInputState == "invalid_length" ?
                          "비밀번호를 8-15자 사이로 입력해 주세요" :
                          "",
                          style: TextStyle(
                            fontFamily: CustomText.body7.fontFamily,
                            fontWeight: CustomText.body7.fontWeight,
                            fontSize: CustomText.body7.fontSize,
                            color: CustomColor.error,
                          ),
                        ),
                      ],
                    ),
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
                    controller: passwordConfirmInputController,
                    onChanged: (String pwd) {},
                    hintText: '비밀번호를 한 번 더 입력하세요',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    enabledBorder: passwordInputState == "not_matched" ? 
                      CustomColor.error : 
                      CustomColor.lightGray,
                    focusedBorder: passwordInputState == "not_matched" ? 
                      CustomColor.error : 
                      CustomColor.primaryBlue100,
                  ),
                  Visibility(
                    visible: passwordInputState == "not_matched" ? true : false,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          passwordInputState == "not_matched" ?
                          "비밀번호가 맞지 않아요" :
                          "",
                          style: TextStyle(
                            fontFamily: CustomText.body7.fontFamily,
                            fontWeight: CustomText.body7.fontWeight,
                            fontSize: CustomText.body7.fontSize,
                            color: CustomColor.error,
                          ),
                        ),
                      ],
                    ),
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

  void validateConditionAndGoToThirdScreen(WidgetRef ref) {
    // 이메일 유효성 검증
    bool emailResult = validateEmail(ref, context, emailInputController.text);

    if(!emailResult) return;

    // 인증코드 유효성 검증
    bool codeResult = validateCode(ref, context, codeInputController.text, emailInputController.text);

    if(!codeResult) return;

    // 비밀번호 유효성 검증
    bool passwordResult = validatePassword(ref, context, passwordInputController.text, passwordConfirmInputController.text);

    if(!passwordResult) return;

    // 회원가입 세 번째 페이지로 이동
    context.goNamed('register_third_screen');
  }
}
