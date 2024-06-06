import 'package:amitamin_frontend/controller/controller.dart';
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
  TextEditingController vCodeInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController passwordConfirmInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final registerEmailInputState = ref.watch(RegisterController.registerEmailInputProvider);
    final registerEmailInputResultState = ref.watch(RegisterController.registerEmailInputResultProvider);
    final registerEmailButtonState = ref.watch(RegisterController.registerEmailButtonProvider);
    final registerEmailButtonPressedState = ref.watch(RegisterController.registerEmailButtonPressedProvider);
    // final registerVerificationCodeInputState = ref.watch(RegisterController.registerVerificationCodeInputProvider);
    final registerVerificationCodeInputResultState = ref.watch(RegisterController.registerVerificationCodeInputResultProvider);
    final registerVerificationCodeButtonState = ref.watch(RegisterController.registerVerificationCodeButtonProvider);
    // final registerPasswordInputState = ref.watch(RegisterController.registerPasswordInputProvider);
    final registerPasswordInputResultState = ref.watch(RegisterController.registerPasswordInputResultProvider);
    // final registerPasswordConfirmInputState = ref.watch(RegisterController.registerPasswordConfirmInputProvider);
    final registerPasswordConfirmInputResultState = ref.watch(RegisterController.registerPasswordConfirmInputResultProvider);

    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '회원가입',
        leadingDisable: true,
        actionDisable: false,
        actionOnPressed: () {
          showConfirmDialog(
            context: context, 
            middleText: Sentence.REGISTER_EXIT, 
            onConfirm: () async {
              await RegisterController.fnInvalidateAll(ref);
              if(!context.mounted) return;
              context.replace('/login_screen');
            }
          );
        },
      ),
      bottomNavigationBar: RegisterBottomNavigationBar(
        backOnTap: () async {
          await RegisterController.fnInvalidateSecondScreen(ref);
          if(!context.mounted) return;
          context.pop();
        },
        text: "2 / 3",
        nextOnTap: () => RegisterController.fnGoToNext(ref, context, 2),
      ),
      child: WillPopScope(
        onWillPop: () async {
          showConfirmDialog(
            context: context, 
            middleText: Sentence.REGISTER_EXIT, 
            onConfirm: () async {
              await RegisterController.fnInvalidateAll(ref);
              if(!context.mounted) return;
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
                            // 인증하기 버튼 활성화/비활성화
                            ref.read(RegisterController.registerEmailButtonProvider.notifier).activate(
                              emailInputController.text
                            );
                            // 이메일 인풋값 세팅
                            ref.read(RegisterController.registerEmailInputProvider.notifier).set(emailInputController.text);
                            // 이메일 인풋 상태코드 세팅
                            ref.read(RegisterController.registerEmailInputResultProvider.notifier).set(
                              RegisterController.fnGetEmailInputCode(emailInputController.text)
                            );
                          },
                          hintText: "이메일을 입력하세요",
                          keyboardType: TextInputType.emailAddress,
                          enabledBorder: RegisterController.fnValidateEmailInput(registerEmailInputResultState) ?
                                            CustomColor.lightGray :
                                            CustomColor.error,
                          focusedBorder: RegisterController.fnValidateEmailInput(registerEmailInputResultState) ?
                                            CustomColor.primaryBlue100 :
                                            CustomColor.error,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: BlueTextButton(
                          onPressed: () async {
                            await RegisterController.fnSendVerificationCodeExec(ref, context);
                          },
                          text: "인증하기",
                          disabled: !registerEmailButtonState,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: !RegisterController.fnValidateEmailInput(registerEmailInputResultState),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          RegisterController.fnGetEmailInputCodeStr(registerEmailInputResultState),
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
                    visible: registerEmailButtonPressedState,
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
                                controller: vCodeInputController,
                                onChanged: (String vCode) {
                                  // 인증확인 버튼 활성화/비활성화
                                  ref.read(RegisterController.registerVerificationCodeButtonProvider.notifier).activate(
                                    vCodeInputController.text
                                  );
                                  // 인증코드 인풋값 세팅
                                  ref.read(RegisterController.registerVerificationCodeInputProvider.notifier).set(vCodeInputController.text);
                                  // 이메일 인풋 상태코드 세팅
                                  ref.read(RegisterController.registerVerificationCodeInputResultProvider.notifier).set(
                                    RegisterController.fnGetVerificationCodeInputCode(vCodeInputController.text)
                                  );
                                },
                                hintText: "인증번호를 입력하세요",
                                keyboardType: TextInputType.emailAddress,
                                inputFormatter: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                enabledBorder: RegisterController.fnValidateVerificationCodeInput(registerVerificationCodeInputResultState) ?
                                                  CustomColor.lightGray :
                                                  CustomColor.error,
                                focusedBorder: RegisterController.fnValidateVerificationCodeInput(registerVerificationCodeInputResultState) ?
                                                  CustomColor.primaryBlue100 :
                                                  CustomColor.error,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: BlueTextButton(
                                onPressed: () async {
                                  await RegisterController.fnVerifyCodeExec(ref, context);
                                },
                                text: "인증확인",
                                disabled: !registerVerificationCodeButtonState,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !RegisterController.fnValidateVerificationCodeInput(registerVerificationCodeInputResultState), 
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          RegisterController.fnGetVerificationCodeInputCodeStr(registerVerificationCodeInputResultState),
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
                    onChanged: (String pwd) {
                      // 비밀번호 인풋값 세팅
                      ref.read(RegisterController.registerPasswordInputProvider.notifier).set(passwordInputController.text);
                      // 비밀번호 인풋 상태코드 세팅
                      ref.read(RegisterController.registerPasswordInputResultProvider.notifier).set(
                        RegisterController.fnGetPasswordInputCode(passwordInputController.text)
                      );
                    },
                    hintText: "비밀번호를 입력하세요",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    enabledBorder: RegisterController.fnValidatePasswordInput(registerPasswordInputResultState) ? 
                                    CustomColor.lightGray : 
                                    CustomColor.error,
                    focusedBorder: RegisterController.fnValidatePasswordInput(registerPasswordInputResultState) ? 
                                    CustomColor.primaryBlue100 : 
                                    CustomColor.error,
                  ),
                  Visibility(
                    visible: !RegisterController.fnValidatePasswordInput(registerPasswordInputResultState),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          RegisterController.fnGetPasswordInputCodeStr(registerPasswordInputResultState),
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
                    onChanged: (String pwd) {
                      // 비밀번호 확인 인풋값 세팅
                      ref.read(RegisterController.registerPasswordConfirmInputProvider.notifier).set(passwordConfirmInputController.text);
                      // 비밀번호 확인 인풋 상태코드 세팅
                      ref.read(RegisterController.registerPasswordConfirmInputResultProvider.notifier).set(
                        RegisterController.fnGetPasswordConfirmInputCode(
                          passwordInputController.text, passwordConfirmInputController.text
                        )
                      );
                    },
                    hintText: "비밀번호를 한 번 더 입력하세요",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    enabledBorder: RegisterController.fnValidatePasswordConfirmInput(registerPasswordConfirmInputResultState) ? 
                      CustomColor.lightGray : 
                      CustomColor.error,
                    focusedBorder: RegisterController.fnValidatePasswordConfirmInput(registerPasswordConfirmInputResultState) ? 
                      CustomColor.primaryBlue100 : 
                      CustomColor.error,
                  ),
                  Visibility(
                    visible: //RegisterController.fnValidatePasswordInput(registerPasswordInputResultState) && 
                             !RegisterController.fnValidatePasswordConfirmInput(registerPasswordConfirmInputResultState),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          RegisterController.fnGetPasswordConfirmInputCodeStr(registerPasswordConfirmInputResultState),
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
}
