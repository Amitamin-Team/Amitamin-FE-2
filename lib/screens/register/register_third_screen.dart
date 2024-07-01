import 'package:amitamin_frontend/controller/controller.dart';
import 'package:amitamin_frontend/data/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'register_navigationbar.dart';

import 'package:amitamin_frontend/common/common.dart';

import 'widget/widget.dart';

class RegisterThirdScreen extends ConsumerStatefulWidget {
  const RegisterThirdScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterThirdScreen> createState() =>
      RegisterThirdScreenState();
}

class RegisterThirdScreenState extends ConsumerState<RegisterThirdScreen> with RegisterController {
  TextEditingController etcInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registerSurveyCheckState = ref.watch(registerSurveyCheckProvider);
    // final registerSurveyEtcInputState = ref.watch(registerSurveyEtcInputProvider);

    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '가입설문',
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
          await fnInvalidateThirdScreen(ref);
          if(!context.mounted) return;
          context.pop();
        },
        text: "3 / 3",
        nextOnTap: () async {
          await fnGoToNext(ref, context, 3);
        },
        nextText: "완료",
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
                  const Text(
                    "아미타민을 통해 무엇을 얻고 싶으신가요?",
                    style: CustomText.body3,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          ref.read(registerSurveyCheckProvider.notifier).set("1");
                          etcInputController.text = "";
                          ref.read(registerSurveyEtcInputProvider.notifier).set(etcInputController.text);
                        },
                        child: registerSurveyCheckState == "1" ? SvgPicture.asset(
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
                        width: 5,
                      ),
                      const Text("나의 피로 분석", style: CustomText.body5),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: CustomColor.lightGray,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          ref.read(registerSurveyCheckProvider.notifier).set("2");
                          etcInputController.text = "";
                          ref.read(registerSurveyEtcInputProvider.notifier).set(etcInputController.text);
                        },
                        child: registerSurveyCheckState == "2" ? SvgPicture.asset(
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
                        width: 5,
                      ),
                      const Text("피로 관리 방법", style: CustomText.body5),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: CustomColor.lightGray,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          ref.read(registerSurveyCheckProvider.notifier).set("3");
                          etcInputController.text = "";
                          ref.read(registerSurveyEtcInputProvider.notifier).set(etcInputController.text);
                        },
                        child: registerSurveyCheckState == "3" ? SvgPicture.asset(
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
                        width: 5,
                      ),
                      const Text("건강한 생활습과 실천", style: CustomText.body5),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: CustomColor.lightGray,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              ref.read(registerSurveyCheckProvider.notifier).set("4");
                            },
                            child: registerSurveyCheckState.contains("4") ? SvgPicture.asset(
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
                            width: 5,
                          ),
                          const Text("기타 (직접 입력)", style: CustomText.body5),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 24,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 61,
                            height: 36,
                            child: OutlinedEtcInput(
                              controller: etcInputController,
                              onChanged: (String etc) {
                                ref.read(registerSurveyEtcInputProvider.notifier).set(etcInputController.text);
                              },
                              hintText: "내용을 입력하세요",
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: CustomColor.lightGray,
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
