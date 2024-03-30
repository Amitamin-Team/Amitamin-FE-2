import 'package:amitamin_frontend/data/provider/provider.dart';
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
        nextOnTap: () {
          // TODO : 회원가입 API 연동

          fnInitRegisterProviders(ref, "all");
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
                          ref.read(surveyRadioProvider.notifier).setState("1");
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
                          ref.read(surveyRadioProvider.notifier).setState("2");
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
                          ref.read(surveyRadioProvider.notifier).setState("3");
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
                              ref.read(surveyRadioProvider.notifier).setState("4");
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
                              onChanged: (String pwd) {},
                              hintText: '내용을 입력해주세요',
                              keyboardType: TextInputType.text,
                              obscureText: true,
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
