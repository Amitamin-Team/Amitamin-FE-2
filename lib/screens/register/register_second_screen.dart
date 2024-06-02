import 'package:amitamin_frontend/data/data.dart';
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
    final emailButtonState = ref.watch(RegisterScreenProvider.emailButtonProvider);
    final emailButtonOnPressedState = ref.watch(RegisterScreenProvider.emailButtonOnPressedProvider);
    final emailInputState = ref.watch(RegisterScreenProvider.emailInputProvider);
    final verificationCodeButtonState = ref.watch(RegisterScreenProvider.verificationCodeButtonProvider);
    final verificationCodeInputState = ref.watch(RegisterScreenProvider.verificationCodeInputProvider);
    final passwordInputState = ref.watch(RegisterScreenProvider.passwordInputProvider);

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
              await RegisterScreenProvider.fnInvalidateAll(ref);
              if(!context.mounted) return;
              context.replace('/login_screen');
            }
          );
        },
      ),
      bottomNavigationBar: RegisterBottomNavigationBar(
        backOnTap: () async {
          await RegisterScreenProvider.fnInvalidateSecondScreen(ref);
          if(!context.mounted) return;
          context.pop();
        },
        text: "2 / 3",
        nextOnTap: () => RegisterScreenProvider.fnGoToNext(ref, context, 2, emailInput: emailInputController.text, codeInput: codeInputController.text, 
                                                                            passwdInput: passwordInputController.text),
      ),
      child: WillPopScope(
        onWillPop: () async {
          showConfirmDialog(
            context: context, 
            middleText: Sentence.REGISTER_EXIT, 
            onConfirm: () async {
              await RegisterScreenProvider.fnInvalidateAll(ref);
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
                    Sentence.REGISGER_GUIDE_2,
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
                            ref.read(RegisterScreenProvider.emailButtonProvider.notifier).activate(
                              emailInputController.text
                            );
                            ref.read(RegisterScreenProvider.emailInputProvider.notifier).set(
                              RegisterScreenProvider.fnInputValidate(emailInputController.text, ProjectConstant.REG_EMAIL_TYPE)
                            );
                            ref.read(RegisterScreenProvider.emailButtonOnPressedProvider.notifier).setStateLinkedEmail(emailInputState);
                          },
                          hintText: Sentence.EMAIL_HINT_TEXT,
                          keyboardType: TextInputType.emailAddress,
                          enabledBorder: !RegisterScreenProvider.fnGetInputBoolState(emailInputState) ?
                                            CustomColor.error :
                                            CustomColor.lightGray,
                          focusedBorder: !RegisterScreenProvider.fnGetInputBoolState(emailInputState) ?
                                            CustomColor.error :
                                            CustomColor.primaryBlue100,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: BlueTextButton(
                          onPressed: () {
                            ref.read(RegisterScreenProvider.emailInputProvider.notifier).set(
                              RegisterScreenProvider.fnInputValidate(emailInputController.text, ProjectConstant.REG_EMAIL_TYPE)
                            );
                            print(emailInputState);
                            if(emailInputState == ProjectConstant.INPUT_CODE_MAP['0009']!['value']!) {
                              // TODO : 인증하기 로직 추가

                              // toast 메시지
                              messageToast(context, "인증번호를 메일로 보냈어요");

                              ref.read(RegisterScreenProvider.emailButtonOnPressedProvider.notifier).set(true);
                            }
                          },
                          text: "인증하기",
                          disabled: !emailButtonState,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: !RegisterScreenProvider.fnGetInputBoolState(emailInputState),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          emailInputState == ProjectConstant.INPUT_CODE_MAP['0001']!['value']! ?
                          Sentence.EMAIL_INPUT_EMPTY_ERR :
                          emailInputState == ProjectConstant.INPUT_CODE_MAP['0003']!['value']! ?
                          Sentence.EMAIL_INPUT_FORMAT_ERR :
                          emailInputState == ProjectConstant.INPUT_CODE_MAP['0011']!['value']! ?
                          Sentence.EMAIL_INPUT_ALREADY_ERR :
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
                    visible: RegisterScreenProvider.fnGetInputBoolState(emailInputState) && 
                             emailButtonOnPressedState,
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
                                  ref.read(RegisterScreenProvider.verificationCodeButtonProvider.notifier).activate(
                                    codeInputController.text 
                                  );
                                },
                                hintText: Sentence.CODE_HINT_TEXT,
                                keyboardType: TextInputType.emailAddress,
                                inputFormatter: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                enabledBorder: !RegisterScreenProvider.fnGetInputBoolState(verificationCodeInputState) ?
                                                  CustomColor.error :
                                                  CustomColor.lightGray,
                                focusedBorder: !RegisterScreenProvider.fnGetInputBoolState(verificationCodeInputState) ?
                                                  CustomColor.error :
                                                  CustomColor.primaryBlue100,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: BlueTextButton(
                                onPressed: () {
                                  ref.read(RegisterScreenProvider.verificationCodeInputProvider.notifier).set(
                                    RegisterScreenProvider.fnInputValidate(codeInputController.text, ProjectConstant.REG_CODE_TYPE)
                                  );

                                  if(verificationCodeInputState == ProjectConstant.INPUT_CODE_MAP['0009']!['value']!) {
                                    // TODO : 인증번호 확인 로직 추가
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
                    visible: !RegisterScreenProvider.fnGetInputBoolState(verificationCodeInputState),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          verificationCodeInputState == ProjectConstant.INPUT_CODE_MAP['0001']!['value']! ?
                          Sentence.CODE_INPUT_EMPTY_ERR :
                          verificationCodeInputState == ProjectConstant.INPUT_CODE_MAP['0004']!['value']! ?
                          Sentence.CODE_INPUT_MATCH_ERR :
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
                    onChanged: (String pwd) {
                      ref.read(RegisterScreenProvider.passwordInputProvider.notifier).set(
                        RegisterScreenProvider.fnInputValidate(passwordInputController.text, ProjectConstant.REG_PASSWD_TYPE)
                      );
                    },
                    hintText: Sentence.PASSWD_HINT_TEXT,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    enabledBorder: !RegisterScreenProvider.fnGetInputBoolState(passwordInputState) &&
                                    passwordInputState != ProjectConstant.INPUT_CODE_MAP['0004']!['value']! ? 
                                    CustomColor.error : 
                                    CustomColor.lightGray,
                    focusedBorder: !RegisterScreenProvider.fnGetInputBoolState(passwordInputState) &&
                                    passwordInputState != ProjectConstant.INPUT_CODE_MAP['0004']!['value']! ? 
                                    CustomColor.error : 
                                    CustomColor.primaryBlue100,
                  ),
                  Visibility(
                    visible: !RegisterScreenProvider.fnGetInputBoolState(passwordInputState) &&
                              passwordInputState != ProjectConstant.INPUT_CODE_MAP['0004']!['value']!,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          passwordInputState == ProjectConstant.INPUT_CODE_MAP['0001']!['value']! ?
                          Sentence.PASSWD_INPUT_EMPTY_ERR :
                          passwordInputState == ProjectConstant.INPUT_CODE_MAP['0002']!['value']! ?
                          Sentence.PASSWD_INPUT_LENGTH_ERR :
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
                    onChanged: (String pwd) {
                      ref.read(RegisterScreenProvider.passwordInputProvider.notifier).set(
                        RegisterScreenProvider.fnInputValidate(passwordInputController.text, ProjectConstant.REG_PASSWD_TYPE, etcValue: passwordConfirmInputController.text)
                      );
                    },
                    hintText: Sentence.PASSWD_CONFIRM_HINT_TEXT,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    enabledBorder: passwordInputState == ProjectConstant.INPUT_CODE_MAP['0004']!['value']! ? 
                      CustomColor.error : 
                      CustomColor.lightGray,
                    focusedBorder: passwordInputState == ProjectConstant.INPUT_CODE_MAP['0004']!['value']! ? 
                      CustomColor.error : 
                      CustomColor.primaryBlue100,
                  ),
                  Visibility(
                    visible: passwordInputState == ProjectConstant.INPUT_CODE_MAP['0004']!['value']! ? true : false,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          passwordInputState == ProjectConstant.INPUT_CODE_MAP['0004']!['value']! ?
                          Sentence.PASSWD_INPUT_MATCH_ERR :
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
}
