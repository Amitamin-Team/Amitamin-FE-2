import 'package:amitamin_frontend/common/common.dart';
import 'package:amitamin_frontend/data/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class RootScreen extends ConsumerWidget {
  final Widget child;

  const RootScreen({
    required this.child, 
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentScreenIndex = ref.watch(bottomNavProvider);

    return DefaultLayout(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: CustomColor.white,
        elevation: 1.0,
        currentIndex: currentScreenIndex,
        onTap: (index) {
          // 인덱스 상태 갱신
          ref.read(bottomNavProvider.notifier).changeBottomNavIndex(index);
          // 화면 이동
          if(index == 0) {
            context.goNamed('home_screen');
          } else if(index == 1) {
            context.goNamed('analysis_screen');
          } else if(index == 2) {
            context.goNamed('my_screen');
          }
        },
        items: [
          BottomNavigationBarItem(
            label: '홈',
            icon: SvgPicture.asset(
              'assets/icons/system/home_icon_outlined.svg',
              width: 24,
              height: 24,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/system/home_icon_filled.svg',
              width: 24,
              height: 24,
            ),
          ),
          BottomNavigationBarItem(
            label: '분석',
            icon: SvgPicture.asset(
              'assets/icons/system/analysis_icon_outlined.svg',
              width: 24,
              height: 24,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/system/analysis_icon_filled.svg',
              width: 24,
              height: 24,
            ),
          ),
          BottomNavigationBarItem(
            label: '마이페이지',
            icon: SvgPicture.asset(
              'assets/icons/system/my_icon_outlined.svg',
              width: 24,
              height: 24,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/system/my_icon_filled.svg',
              width: 24,
              height: 24,
            ),
          ),
        ]
      ),
      child: child,
    );
  }
}