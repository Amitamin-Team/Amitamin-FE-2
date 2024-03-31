import 'package:amitamin_frontend/data/data.dart';
import 'package:amitamin_frontend/data/provider/register_providers/birth_input_provider.dart';
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
  TextEditingController birthInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nicknameButtonState = ref.watch(nicknameButtonProvider);
    final nicknameInputState = ref.watch(nicknameInputProvider);
    final genderButtonState = ref.watch(genderButtonProvider);
    final birthInputState = ref.watch(birthInputProvider);
    final privateRadioState = ref.watch(privateRadioProvider);
    final registerModelState = ref.watch(registerModelProvider);

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
        nextOnTap: () => goToNextScreen(ref),
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
                          enabledBorder: ref.read(nicknameInputProvider.notifier).getValidBoolState() ? 
                                            CustomColor.error :
                                            CustomColor.lightGray,
                          focusedBorder: ref.read(nicknameInputProvider.notifier).getValidBoolState() ? 
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

                            if(verifyNicknameInputResult == "pass_valid") {
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
                    visible: ref.read(nicknameInputProvider.notifier).getValidBoolState(),
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
                            nicknameInputState == "duplicated" ?
                            "중복된 닉네임이 있어요" :
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
                    controller: birthInputController,
                    onChanged: (String birth) {},
                    hintText: '생년월일을 입력하세요 (예: 1900-01-01)',
                    keyboardType: TextInputType.number,
                    inputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                      BirthdayInputFormatter(),
                    ],
                    enabledBorder: ref.read(birthInputProvider.notifier).getValidBoolState() ? 
                                      CustomColor.error :
                                      CustomColor.lightGray,
                    focusedBorder: ref.read(birthInputProvider.notifier).getValidBoolState() ? 
                                      CustomColor.error :
                                      CustomColor.primaryBlue100,
                  ),
                  Visibility(
                    visible: ref.read(birthInputProvider.notifier).getValidBoolState(),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          birthInputState == "no_data" ?
                            "생년월일을 입력해주세요" :
                            birthInputState == "invalid_length" ?
                            "생년월일을 정확히 입력해주세요" :
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

  void goToNextScreen(WidgetRef ref) {
    // 닉네임 유효성 검증
    String verifyNicknameInputResult = ref.read(nicknameInputProvider.notifier).validate(
      nicknameInputController.text
    );

    // TODO : 닉네임 중복확인 후 pass_all, 추후에 pass_valid 제외시켜야 함
    if(verifyNicknameInputResult == "pass_all" || verifyNicknameInputResult == "pass_valid") {
      ref.read(registerModelProvider.notifier).setNickname(nicknameInputController.text);
    } else {
      if(verifyNicknameInputResult == "no_data") {
        showAlertDialog(context: context, middleText: "닉네임을 입력해주세요.");
      }
      if(verifyNicknameInputResult == "length_over_8") {
        showAlertDialog(context: context, middleText: "닉네임은 최대 8글자까지 입력할 수 있어요.");
      }
      /*if(verifyNicknameInputResult == "pass_valid") {
        showAlertDialog(context: context, middleText: "닉네임 중복확인을 해주세요.");
      }*/
      if(verifyNicknameInputResult == "duplicated") {
        showAlertDialog(context: context, middleText: "중복된 닉네임이 있어요.");
      }
      return;
    }

    // 성별 유효성 검증
    String sex = ref.read(genderButtonProvider.notifier).get();
    if(sex != "") {
      ref.read(registerModelProvider.notifier).setGender(sex);
    } else {
      showAlertDialog(context: context, middleText: "성별을 선택해주세요.");
      return;
    }

    // 생년월일 유효성 검증
    String verifyBirthInputResult = ref.read(birthInputProvider.notifier).validate(
      birthInputController.text
    );

    if(verifyBirthInputResult == "pass_all") {
      // 19900101 -> 1990-01-01
      // String formatBirth = "${birthInputController.text.substring(0, 4)}-${birthInputController.text.substring(4, 6)}-${birthInputController.text.substring(6)}";
      
      ref.read(registerModelProvider.notifier).setBirth(birthInputController.text);
    } else {
      if(verifyBirthInputResult == "no_data") {
        showAlertDialog(context: context, middleText: "생년월일을 입력해주세요.");
      }
      if(verifyBirthInputResult == "invalid_length") {
        showAlertDialog(context: context, middleText: "생년월일을 정확히 입력해주세요.");
      }
      return;
    }

    // 개인정보 처리 방침 동의 검증
    bool private_yn = ref.read(privateRadioProvider.notifier).get();
    if(private_yn) {
      ref.read(registerModelProvider.notifier).setPrivateYN("Y");
    } else {
      showAlertDialog(context: context, middleText: "개인정보 처리 방침에 동의해주세요.");
      return;
    }

    context.goNamed('register_second_screen');
  }
}
