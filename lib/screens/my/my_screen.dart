import 'package:amitamin_frontend/common/common.dart';
import 'package:amitamin_frontend/screens/my/widget/widget.dart';
import 'package:amitamin_frontend/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:go_router/go_router.dart';

class MyScreen extends ConsumerStatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MyScreen> createState() => MyScreenState();
}

class MyScreenState extends ConsumerState<MyScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColor.backGround,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: CustomColor.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 28,
                      ),
                      Row(
                        children: [
                          Text(
                            "문동은님",
                            style: TextStyle(
                                color: CustomColor.black,
                                fontSize: CustomText.headLine7.fontSize,
                                fontFamily: CustomText.headLine7.fontFamily,
                                fontWeight: CustomText.headLine7.fontWeight),
                          ),
                          SvgPicture.asset(
                            'assets/icons/my/ic_woman_line.svg',
                            width: 16,
                            height: 17,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'abcd@naver.com',
                            style: TextStyle(
                              color: CustomColor.gray,
                              fontFamily: CustomText.body6.fontFamily,
                              fontSize: CustomText.body6.fontSize,
                              fontWeight: CustomText.body6.fontWeight,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              context.goNamed('my_profile_screen');
                            },
                            child: Text(
                              '프로필 편집',
                              style: TextStyle(
                                color: CustomColor.primaryBlue100,
                                fontFamily: CustomText.body6.fontFamily,
                                fontSize: CustomText.body6.fontSize,
                                fontWeight: CustomText.body5.fontWeight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 12,
                color: CustomColor.white,
              ),
              MySubMenuContainer(
                menuName: "나의 설문지 내역",
                svgPath: "assets/icons/shortcut/gray_arrow_next.svg",
                svgFlag: true,
                voidCallback: () {},
              ),
              const SizedBox(
                height: 12,
              ),
              MySubMenuContainer(
                menuName: "앱 잠금 설정",
                svgPath: "",
                svgFlag: false,
                widget: Switch(
                  value: false,
                  onChanged: (value) {
                    // TODO : 행 전체를 클릭 시 switch 작동
                  },
                ),
                voidCallback: () {},
              ),
              const SizedBox(
                height: 1,
              ),
              MySubMenuContainer(
                menuName: "알림 설정",
                svgPath: "",
                svgFlag: false,
                widget: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
                voidCallback: () {},
              ),
              const SizedBox(
                height: 1,
              ),
              MySubMenuContainer(
                menuName: "튜토리얼",
                svgPath: "assets/icons/shortcut/gray_arrow_next.svg",
                svgFlag: true,
                voidCallback: () {},
              ),
              const SizedBox(
                height: 1,
              ),
              MySubMenuContainer(
                menuName: "문의하기",
                svgPath: "assets/icons/shortcut/gray_arrow_upward_right.svg",
                svgFlag: true,
                voidCallback: () {},
              ),
              const SizedBox(
                height: 1,
              ),
              MySubMenuContainer(
                menuName: "버전 정보 0.0.0",
                svgPath: "",
                svgFlag: false,
                widget: Text(
                  '업데이트',
                  style: TextStyle(
                    color: CustomColor.primaryBlue100,
                    fontFamily: CustomText.body6.fontFamily,
                    fontSize: CustomText.body7.fontSize,
                    fontWeight: CustomText.body6.fontWeight,
                  ),
                ),
                voidCallback: () {},
              ),
              const SizedBox(
                height: 1,
              ),
              MySubMenuContainer(
                menuName: "이용약관",
                svgPath: "assets/icons/shortcut/gray_arrow_upward_right.svg",
                svgFlag: true,
                voidCallback: () {},
              ),
              const SizedBox(
                height: 1,
              ),
              MySubMenuContainer(
                menuName: "로그아웃",
                svgPath: "",
                svgFlag: false,
                voidCallback: () {
                  showConfirmDialog(
                    context: context, 
                    middleText: "정말 로그아웃 하시겠습니까?", 
                    onConfirm: () async {
                      await MyController.fnLoginOutExec(ref, context);
                    }
                  );
                },
              ),
              const SizedBox(
                height: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "회원탈퇴",
                    style: TextStyle(
                        color: CustomColor.gray,
                        fontSize: CustomText.body5.fontSize,
                        fontFamily: CustomText.body4.fontFamily,
                        fontWeight: CustomText.body3.fontWeight),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
