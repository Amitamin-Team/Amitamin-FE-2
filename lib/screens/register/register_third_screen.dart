import 'package:amitamin_frontend/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'register_navigationbar.dart';

import 'package:amitamin_frontend/common/common.dart';

import 'utils/utils.dart';
import 'widget/widget.dart';

class RegisterThirdScreen extends ConsumerStatefulWidget {
  const RegisterThirdScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterThirdScreen> createState() =>
      RegisterThirdScreenState();
}

class RegisterThirdScreenState extends ConsumerState<RegisterThirdScreen> {
  TextEditingController etcInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final surveyRadioState = ref.watch(surveyRadioProvider);

    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '가입설문',
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
        backOnTap: () => context.pop(),
        text: "3 / 3",
        nextOnTap: () async {
          // await register(ref);
          context.replace('/login_screen');
        },
        nextText: "완료",
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
                          ref.read(surveyRadioProvider.notifier).set("1");
                        },
                        child: surveyRadioState == "1" ? SvgPicture.asset(
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
                          ref.read(surveyRadioProvider.notifier).set("2");
                        },
                        child: surveyRadioState == "2" ? SvgPicture.asset(
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
                          ref.read(surveyRadioProvider.notifier).set("3");
                        },
                        child: surveyRadioState == "3" ? SvgPicture.asset(
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
                              ref.read(surveyRadioProvider.notifier).set("4");
                            },
                            child: surveyRadioState == "4" ? SvgPicture.asset(
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
                              onChanged: (String pwd) {},
                              hintText: '내용을 입력해주세요',
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

  Future<void> register(WidgetRef ref) async {
    bool surveyResult = validateSurvey(ref, context, 
                                       ref.read(surveyRadioProvider.notifier).get(), etcInputController.text);

    if(!surveyResult) return;

    /* String survey_summary = ref.read(surveyRadioProvider.notifier).get();

    if(survey_summary == "") {
      showAlertDialog(context: context, middleText: "가입설문 내용을 선택해주세요.");
      return;
    } else if (survey_summary == "4") {
      if(etcInputController.text.isEmpty) {
        showAlertDialog(context: context, middleText: "기타의 내용을 입력해주세요.");
        return;
      }
      survey_summary += ", ${etcInputController.text}";
      ref.read(registerModelProvider.notifier).setSurvey(survey_summary);
    } else {
      ref.read(registerModelProvider.notifier).setSurvey(survey_summary);
    } */

    final response = await ref.read(registerRepositoryProvider).requestRegisterRepository(
      requestRegisterModel: ref.read(registerModelProvider.notifier).get()
    );

    if(response.response_code == 200) {
      fnInitRegisterProviders(ref, "all");

      if(context.mounted) {
        context.replace('/login_screen');
      }
    } else {
      if(context.mounted) {
        showConfirmDialog(
          context: context, 
          middleText: "회원가입에 실패했습니다.\n로그인 화면으로 이동합니다.", 
          onConfirm: () {
            fnInitRegisterProviders(ref, "all");
            context.replace('/login_screen');
          }
        );
      }
    }
  }
}
