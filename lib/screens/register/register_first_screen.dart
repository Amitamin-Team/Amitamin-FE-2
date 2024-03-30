import 'package:amitamin_frontend/data/data.dart';
import 'package:amitamin_frontend/screens/register/utils/utils.dart';
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

  @override
  Widget build(BuildContext context) {
    final nicknameButtonState = ref.watch(nicknameButtonProvider);
    final nicknameInputState = ref.watch(nicknameInputProvider);
    final genderButtonState = ref.watch(genderButtonProvider);
    final privateRadioState = ref.watch(privateRadioProvider);

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
          fnInitRegisterProviders(ref, "all");
          context.replace('/login_screen');
        },
        text: "1 / 3",
        nextOnTap: () => context.goNamed('register_second_screen'),
      ),
      child: WillPopScope(
        onWillPop: () async {
          showConfirmDialog(
            context: context, 
            middleText: Sentence.registerExitQuestion, 
            onConfirm: () {
              fnInitRegisterProviders(ref, "1");
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
                    "입력한 정보는 앱 이용을 위해서만 활용됩니다.",
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
                            ref.read(nicknameButtonProvider.notifier).activate(
                              nicknameInputController.text
                            );
                          },
                          hintText: '닉네임을 입력하세요',
                          keyboardType: TextInputType.text,
                          enabledBorder: (nicknameInputState != "pass" && 
                                          nicknameInputState != "init") ? 
                                            CustomColor.error :
                                            CustomColor.primaryBlue100,
                          focusedBorder: (nicknameInputState != "pass" && 
                                          nicknameInputState != "init") ? 
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
                            String verifyNicknameInputResult = ref.read(nicknameInputProvider.notifier).validate(
                              nicknameInputController.text
                            );

                            if(verifyNicknameInputResult == "pass") {
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
                    visible: (nicknameInputState != "pass" && 
                              nicknameInputState != "init") ? true : false,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          nicknameInputState == "no_data" ?
                            "닉네임을 입력해주세요" :
                            nicknameInputState == "length_over_8" ?
                            "최대 8글자까지 입력할 수 있어요" :
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
                            ref.read(genderButtonProvider.notifier).set("F");
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
                            ref.read(genderButtonProvider.notifier).set("M");
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
                    onChanged: (String birth) {},
                    hintText: '생년월일을 입력하세요 (예: 1900-01-01)',
                    keyboardType: TextInputType.number,
                    inputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                      BirthdayInputFormatter(),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // radio button toggle 수행
                          ref.read(privateRadioProvider.notifier).toggle();
                        },
                        child: privateRadioState ? SvgPicture.asset(
                          "assets/icons/radio_checked.svg",
                          width: 24,
                          height: 24,
                        ) : SvgPicture.asset(
                          "assets/icons/radio_unchecked.svg",
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
