import 'package:amitamin_frontend/data/data.dart';
import 'package:amitamin_frontend/screens/register/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  TextEditingController nicknameInputController = TextEditingController();
  TextEditingController birthInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nicknameButtonState = ref.watch(RegisterScreenProvider.nicknameButtonProvider);
    final nicknameInputState = ref.watch(RegisterScreenProvider.nicknameInputProvider);
    final genderButtonState = ref.watch(RegisterScreenProvider.genderButtonProvider);
    final birthInputState = ref.watch(RegisterScreenProvider.birthInputProvider);
    final privateRadioState = ref.watch(RegisterScreenProvider.privateRadioProvider);

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
          await RegisterScreenProvider.fnInvalidateAll(ref);
          if(!context.mounted) return;
          context.replace('/login_screen');
        },
        text: "1 / 3",
        nextOnTap: () => RegisterScreenProvider.fnGoToNext(ref, context, 1, nicknameInput: nicknameInputController.text, birthInput: birthInputController.text),
      ),
      child: WillPopScope(
        onWillPop: () async {
          showConfirmDialog(
            context: context, 
            middleText: Sentence.REGISTER_EXIT, 
            onConfirm: () async {
              await RegisterScreenProvider.fnInvalidateFirstScreen(ref);
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
                  Text(
                    Sentence.REGISGER_GUIDE_1,
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
                          controller: nicknameInputController,
                          onChanged: (String nickname) {
                            ref.read(RegisterScreenProvider.nicknameButtonProvider.notifier).activate(
                              nicknameInputController.text
                            );
                            ref.read(RegisterScreenProvider.nicknameInputProvider.notifier).set(
                              RegisterScreenProvider.fnInputValidate(nicknameInputController.text, ProjectConstant.REG_NICKNAME_TYPE)
                            );
                          },
                          hintText: Sentence.NICKNAME_HINT_TEXT,
                          keyboardType: TextInputType.text,
                          enabledBorder: !RegisterScreenProvider.fnGetInputBoolState(nicknameInputState) ? 
                                            CustomColor.error :
                                            CustomColor.lightGray,
                          focusedBorder: !RegisterScreenProvider.fnGetInputBoolState(nicknameInputState) ?
                                            CustomColor.error :
                                            CustomColor.primaryBlue100,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: BlueTextButton(
                          onPressed: () {
                            ref.read(RegisterScreenProvider.nicknameInputProvider.notifier).set(
                              RegisterScreenProvider.fnInputValidate(nicknameInputController.text, ProjectConstant.REG_NICKNAME_TYPE)
                            );

                            if(nicknameInputState == ProjectConstant.INPUT_CODE_MAP['0009']!['value']!) {
                              // TODO : 중복확인 로직 추가
                            }
                          },
                          text: "중복확인",
                          disabled: !nicknameButtonState,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: !RegisterScreenProvider.fnGetInputBoolState(nicknameInputState),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                            nicknameInputState == ProjectConstant.INPUT_CODE_MAP['0001']!['value']! ?
                            Sentence.NICKNAME_INPUT_EMPTY_ERR :
                            nicknameInputState == ProjectConstant.INPUT_CODE_MAP['0002']!['value']! ?
                            Sentence.NICKNAME_INPUT_LENGTH_ERR :
                            nicknameInputState == ProjectConstant.INPUT_CODE_MAP['0005']!['value']! ?
                            Sentence.NICKNAME_INPUT_DUPLICATE_ERR :
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
                          onPressed: () {
                            ref.read(RegisterScreenProvider.genderButtonProvider.notifier).set("F");
                          },
                          text: "여성",
                          disabled: genderButtonState != "F" ? true : false,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: BlueTextButton(
                          onPressed: () {
                            ref.read(RegisterScreenProvider.genderButtonProvider.notifier).set("M");
                          },
                          text: "남성",
                          disabled: genderButtonState != "M" ? true : false,
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
                  OutlinedInput(
                    controller: birthInputController,
                    onChanged: (String birth) {
                      ref.read(RegisterScreenProvider.birthInputProvider.notifier).set(
                        RegisterScreenProvider.fnInputValidate(birthInputController.text, ProjectConstant.REG_BIRTH_TYPE)
                      );
                    },
                    hintText: Sentence.BIRTH_HINT_TEXT,
                    keyboardType: TextInputType.number,
                    inputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                      BirthdayInputFormatter(),
                    ],
                    enabledBorder: !RegisterScreenProvider.fnGetInputBoolState(birthInputState) ? 
                                      CustomColor.error :
                                      CustomColor.lightGray,
                    focusedBorder: !RegisterScreenProvider.fnGetInputBoolState(birthInputState) ? 
                                      CustomColor.error :
                                      CustomColor.primaryBlue100,
                  ),
                  Visibility(
                    visible: !RegisterScreenProvider.fnGetInputBoolState(birthInputState),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                            birthInputState == ProjectConstant.INPUT_CODE_MAP['0001']!['value']! ?
                            Sentence.BIRTH_INPUT_EMPTY_ERR :
                            birthInputState == ProjectConstant.INPUT_CODE_MAP['0002']!['value']! ?
                            Sentence.BIRTH_INPUT_LENGTH_ERR :
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
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          privateRadioState == "Y" ?
                            ref.read(RegisterScreenProvider.privateRadioProvider.notifier).set("N") :
                            ref.read(RegisterScreenProvider.privateRadioProvider.notifier).set("Y");
                        },
                        child: privateRadioState == "Y" ? SvgPicture.asset(
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
                      Row(
                        children: [
                          const Text("개인정보 제공에 동의합니다", style: CustomText.body3),
                          Text(
                            " (필수)", 
                            style: TextStyle(
                              fontFamily: CustomText.body3.fontFamily,
                              fontWeight: CustomText.body3.fontWeight,
                              fontSize: CustomText.body3.fontSize,
                              color: CustomColor.primaryBlue100,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          // TODO : 개인정보 처리 방침 페이지로 이동
                        },
                        child: Text(
                          "개인정보 처리 방침",
                          style: TextStyle(
                            fontFamily: CustomText.body4.fontFamily,
                            fontWeight: CustomText.body4.fontWeight,
                            fontSize: CustomText.body4.fontSize,
                            color: CustomColor.darkGray,
                            decoration: TextDecoration.underline,
                          ),
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
    );
  }
}
