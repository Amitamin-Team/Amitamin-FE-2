import 'package:amitamin_frontend/common/common.dart';
import 'package:amitamin_frontend/screens/home/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      appBar: HomeScreenAppBar(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 피로도 부분
                InkWell(
                  onTap: () {
                    // TODO : 화면이동
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 77,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        children: [
                          // TODO : 피로도 점수에 따라 아이콘 바꾸기
                          SvgPicture.asset(
                            'assets/icons/state=0.svg',
                            width: 44,
                            height: 44,
                          ),
                          const SizedBox(width: 12,),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.vertical,
                            children: [
                              // 피로도 점수를 입력했을 경우
                              1 == 1 ? 
                              Text(
                                '오늘의 피로도는 10점 이네요',
                                style: CustomText.headLine5,
                                overflow: TextOverflow.ellipsis,
                              ) : 
                              // 피로도 점수가 없거나 입력하기 전
                              const Text(
                                '오늘 당신의 피로도는 몇점인가요?',
                                style: CustomText.headLine5,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 9,),
                              // TODO : 피로도 점수에 따라 문구 바꾸기
                              Text(
                                '무리하지 말고 휴식을 취해보세요',
                                style: TextStyle(
                                  fontSize: CustomText.body6.fontSize,
                                  fontWeight: CustomText.body6.fontWeight,
                                  fontFamily: CustomText.body6.fontFamily,
                                  color: CustomColor.gray,
                                ),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // 목표리스트 부분
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '목표리스트',
                        style: CustomText.headLine4,
                      ),
                      GestureDetector(
                        onTap: () {
                          // TODO : 목표 입력 화면으로 이동
                        },
                        child: SvgPicture.asset(
                          'assets/icons/home/add.svg',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                // 탭바
                const HomeTabBar(
                  tabs: ["전체", "신체", "영양", "수면", "마음"]
                ),
                // 탭뷰
                HomeTabView(
                  children: [
                    HomeTabViewItem(
                      objectType: 'all',
                      objectItmes: [],
                    ),
                    HomeTabViewItem(
                      objectType: 'body',
                      objectItmes: [
                        Text('body')
                      ],
                    ),
                    HomeTabViewItem(
                      objectType: 'nutrition',
                      objectItmes: [
                        Text('nutrition')
                      ],
                    ),
                    HomeTabViewItem(
                      objectType: 'sleep',
                      objectItmes: [
                        Text('sleep')
                      ],
                    ),
                    HomeTabViewItem(
                      objectType: 'mental',
                      objectItmes: [
                        Text('mental')
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}

class HomeScreenAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeScreenAppBar({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(51.0),
      child: AppBar(
        elevation: 0.0,
        backgroundColor: CustomColor.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            DateFormat('M월 d일 (E)','ko_KR').format(DateTime.now()),
            style: TextStyle(
              fontSize: CustomText.headLine7.fontSize,
              fontWeight: CustomText.headLine7.fontWeight,
              fontFamily: CustomText.headLine7.fontFamily,
              color: CustomColor.primaryBlue100,
            ),
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
        actions: [
          // TODO : 알림 API 적용
          1 == 1
              ? IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/home/alarm_exist.svg',
              width: 24,
              height: 24,
            ),
          )
              : IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/home/alarm_empty.svg',
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(51.0);
}