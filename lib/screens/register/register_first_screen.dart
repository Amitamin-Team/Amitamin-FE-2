import 'package:amitamin_frontend/controller/controller.dart';
import 'package:amitamin_frontend/screens/register/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'register_navigationbar.dart';
import 'package:amitamin_frontend/common/common.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';

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
    // final registerNicknameInputState = ref.watch(RegisterController.registerNicknameInputProvider);
    final registerNicknameInputResultState = ref.watch(RegisterController.registerNicknameInpuResultProvider);
    final registerNicknameButtonState = ref.watch(RegisterController.registerNicknameButtonProvider);
    final registerSexButtonState = ref.watch(RegisterController.registerSexButtonProvider);
    // final registerBirthInputState = ref.watch(RegisterController.registerBirthInputProvider);
    final registerBirthInputResultState = ref.watch(RegisterController.registerBirthInputResultProvider);
    final registerPrivateCheckState = ref.watch(RegisterController.registerPrivateCheckProvider);

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
          await RegisterController.fnInvalidateAll(ref);
          if(!context.mounted) return;
          context.replace('/login_screen');
        },
        text: "1 / 3",
        nextOnTap: () => RegisterController.fnGoToNext(ref, context, 1),
      ),
      child: WillPopScope(
        onWillPop: () async {
          showConfirmDialog(
            context: context, 
            middleText: Sentence.REGISTER_EXIT, 
            onConfirm: () async {
              await RegisterController.fnInvalidateFirstScreen(ref);
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
                            // 중복확인 버튼 활성화/비활성화
                            ref.read(RegisterController.registerNicknameButtonProvider.notifier).activate(
                              nicknameInputController.text
                            );
                            // 닉네임 인풋값 세팅
                            ref.read(RegisterController.registerNicknameInputProvider.notifier).set(nicknameInputController.text);
                            // 닉네임 인풋 상태코드 세팅
                            ref.read(RegisterController.registerNicknameInpuResultProvider.notifier).set(
                              RegisterController.fnGetNicknameInputCode(nicknameInputController.text)
                            );
                          },
                          hintText: "닉네임을 입력하세요",
                          keyboardType: TextInputType.text,
                          enabledBorder: RegisterController.fnValidateInput(registerNicknameInputResultState) ? 
                                            CustomColor.lightGray :
                                            CustomColor.error,
                          focusedBorder: RegisterController.fnValidateInput(registerNicknameInputResultState) ? 
                                            CustomColor.primaryBlue100 :
                                            CustomColor.error,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: BlueTextButton(
                          onPressed: () async {
                            await RegisterController.fnCheckNicknameExecPrev(ref, context);
                          },
                          text: "중복확인",
                          disabled: !registerNicknameButtonState,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: !RegisterController.fnValidateInput(registerNicknameInputResultState),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          RegisterController.fnGetNicknameInputCodeStr(registerNicknameInputResultState),
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
                            ref.read(RegisterController.registerSexButtonProvider.notifier).set("F");
                          },
                          text: "여성",
                          disabled: registerSexButtonState != "F" ? true : false,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: BlueTextButton(
                          onPressed: () {
                            ref.read(RegisterController.registerSexButtonProvider.notifier).set("M");
                          },
                          text: "남성",
                          disabled: registerSexButtonState != "M" ? true : false,
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
                      // 생년월일 인풋값 세팅
                      ref.read(RegisterController.registerBirthInputProvider.notifier).set(birthInputController.text);
                      // 닉네임 인풋 상태코드 세팅
                      ref.read(RegisterController.registerBirthInputResultProvider.notifier).set(
                        RegisterController.fnGetBirthInputCode(birthInputController.text)
                      );
                    },
                    hintText: "생년월일을 입력하세요 (예: 1900-01-01)",
                    keyboardType: TextInputType.number,
                    inputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                      BirthdayInputFormatter(),
                    ],
                    enabledBorder: RegisterController.fnValidateInput(registerBirthInputResultState) ? 
                                    CustomColor.lightGray :
                                    CustomColor.error,
                    focusedBorder: RegisterController.fnValidateInput(registerBirthInputResultState) ? 
                                    CustomColor.primaryBlue100 :
                                    CustomColor.error,
                  ),
                  Visibility(
                    visible: !RegisterController.fnValidateInput(registerBirthInputResultState),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          RegisterController.fnGetBirthInputCodeStr(registerBirthInputResultState),
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
                          registerPrivateCheckState == "Y" ?
                            ref.read(RegisterController.registerPrivateCheckProvider.notifier).set("N") :
                            ref.read(RegisterController.registerPrivateCheckProvider.notifier).set("Y");
                        },
                        child: registerPrivateCheckState == "Y" ? SvgPicture.asset(
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
                          launchUrl(Uri.parse(ProjectConstant.PRIVATE_URL));
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
