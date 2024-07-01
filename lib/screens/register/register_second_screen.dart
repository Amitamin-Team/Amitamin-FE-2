import 'package:amitamin_frontend/controller/controller.dart';
import 'package:amitamin_frontend/data/provider/provider.dart';
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

class RegisterSecondScreenState extends ConsumerState<RegisterSecondScreen> with RegisterController {
  TextEditingController emailInputController = TextEditingController();
  TextEditingController vCodeInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController passwordConfirmInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final registerEmailInputState = ref.watch(registerEmailInputProvider);
    final registerEmailInputResultState = ref.watch(registerEmailInputResultProvider);
    final registerEmailButtonState = ref.watch(registerEmailButtonProvider);
    final registerEmailButtonPressedState = ref.watch(registerEmailButtonPressedProvider);
    // final registerVerificationCodeInputState = ref.watch(registerVerificationCodeInputProvider);
    final registerVerificationCodeInputResultState = ref.watch(registerVerificationCodeInputResultProvider);
    final registerVerificationCodeButtonState = ref.watch(registerVerificationCodeButtonProvider);
    // final registerPasswordInputState = ref.watch(registerPasswordInputProvider);
    final registerPasswordInputResultState = ref.watch(registerPasswordInputResultProvider);
    // final registerPasswordConfirmInputState = ref.watch(registerPasswordConfirmInputProvider);
    final registerPasswordConfirmInputResultState = ref.watch(registerPasswordConfirmInputResultProvider);

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
              await fnInvalidateAll(ref);
              if(!context.mounted) return;
              context.replace('/login_screen');
            }
          );
        },
      ),
      bottomNavigationBar: RegisterBottomNavigationBar(
        backOnTap: () async {
          await fnInvalidateSecondScreen(ref);
          if(!context.mounted) return;
          context.pop();
        },
        text: "2 / 3",
        nextOnTap: () => fnGoToNext(ref, context, 2),
      ),
      child: WillPopScope(
        onWillPop: () async {
          showConfirmDialog(
            context: context, 
            middleText: Sentence.REGISTER_EXIT, 
            onConfirm: () async {
              await fnInvalidateAll(ref);
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
                            ref.read(registerEmailButtonProvider.notifier).activate(
                              emailInputController.text
                            );
                            // 이메일 인풋값 세팅
                            ref.read(registerEmailInputProvider.notifier).set(emailInputController.text);
                            // 이메일 인풋 상태코드 세팅
                            ref.read(registerEmailInputResultProvider.notifier).set(
                              fnGetEmailInputCode(emailInputController.text)
                            );
                          },
                          hintText: "이메일을 입력하세요",
                          keyboardType: TextInputType.emailAddress,
                          enabledBorder: fnValidateInput(registerEmailInputResultState) ?
                                            CustomColor.lightGray :
                                            CustomColor.error,
                          focusedBorder: fnValidateInput(registerEmailInputResultState) ?
                                            CustomColor.primaryBlue100 :
                                            CustomColor.error,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: BlueTextButton(
                          onPressed: () async {
                            await fnSendVerificationCodeExec(ref, context);
                          },
                          text: "인증하기",
                          disabled: !registerEmailButtonState,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: !fnValidateInput(registerEmailInputResultState),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          fnGetEmailInputCodeStr(registerEmailInputResultState),
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
                                  ref.read(registerVerificationCodeButtonProvider.notifier).activate(
                                    vCodeInputController.text
                                  );
                                  // 인증코드 인풋값 세팅
                                  ref.read(registerVerificationCodeInputProvider.notifier).set(vCodeInputController.text);
                                  // 이메일 인풋 상태코드 세팅
                                  ref.read(registerVerificationCodeInputResultProvider.notifier).set(
                                    fnGetVerificationCodeInputCode(vCodeInputController.text)
                                  );
                                },
                                hintText: "인증번호를 입력하세요",
                                keyboardType: TextInputType.emailAddress,
                                inputFormatter: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                enabledBorder: fnValidateInput(registerVerificationCodeInputResultState) ?
                                                  CustomColor.lightGray :
                                                  CustomColor.error,
                                focusedBorder: fnValidateInput(registerVerificationCodeInputResultState) ?
                                                  CustomColor.primaryBlue100 :
                                                  CustomColor.error,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: BlueTextButton(
                                onPressed: () async {
                                  await fnVerifyCodeExec(ref, context);
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
                    visible: !fnValidateInput(registerVerificationCodeInputResultState), 
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          fnGetVerificationCodeInputCodeStr(registerVerificationCodeInputResultState),
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
                      ref.read(registerPasswordInputProvider.notifier).set(passwordInputController.text);
                      // 비밀번호 인풋 상태코드 세팅
                      ref.read(registerPasswordInputResultProvider.notifier).set(
                        fnGetPasswordInputCode(passwordInputController.text)
                      );
                    },
                    hintText: "비밀번호를 입력하세요",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    enabledBorder: fnValidateInput(registerPasswordInputResultState) ? 
                                    CustomColor.lightGray : 
                                    CustomColor.error,
                    focusedBorder: fnValidateInput(registerPasswordInputResultState) ? 
                                    CustomColor.primaryBlue100 : 
                                    CustomColor.error,
                  ),
                  Visibility(
                    visible: !fnValidateInput(registerPasswordInputResultState),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          fnGetPasswordInputCodeStr(registerPasswordInputResultState),
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
                      ref.read(registerPasswordConfirmInputProvider.notifier).set(passwordConfirmInputController.text);
                      // 비밀번호 확인 인풋 상태코드 세팅
                      ref.read(registerPasswordConfirmInputResultProvider.notifier).set(
                        fnGetPasswordConfirmInputCode(
                          passwordInputController.text, passwordConfirmInputController.text
                        )
                      );
                    },
                    hintText: "비밀번호를 한 번 더 입력하세요",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    enabledBorder: fnValidateInput(registerPasswordConfirmInputResultState) ? 
                      CustomColor.lightGray : 
                      CustomColor.error,
                    focusedBorder: fnValidateInput(registerPasswordConfirmInputResultState) ? 
                      CustomColor.primaryBlue100 : 
                      CustomColor.error,
                  ),
                  Visibility(
                    visible: //fnValidateInput(registerPasswordInputResultState) && 
                             !fnValidateInput(registerPasswordConfirmInputResultState),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          fnGetPasswordConfirmInputCodeStr(registerPasswordConfirmInputResultState),
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
