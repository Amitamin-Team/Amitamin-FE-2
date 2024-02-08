import 'package:amitamin_frontend/common/const/const.dart';
import 'package:amitamin_frontend/data/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTabBar extends ConsumerWidget {
  const HomeTabBar({
    Key? key,
    required this.tabs
  }) : super(key: key);

  final List<String> tabs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentHomeTabIndex = ref.watch(homeTabProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 21,
        child: Row(
          children: List.generate(tabs.length, (index) => GestureDetector(
            onTap: () {
              // TODO : 탭 인덱스 변경
              ref.read(homeTabProvider.notifier).changeHomeTabIndex(index);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SizedBox(
                width: 32,
                height: 21,
                child: Text(
                  tabs[index].toString(),
                  style: TextStyle(
                    color: currentHomeTabIndex == index
                        ? CustomColor.black
                        : CustomColor.gray,
                    fontWeight: currentHomeTabIndex == index
                        ? CustomText.body5.fontWeight
                        : CustomText.body6.fontWeight,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            ),
          ),
        ),
      ),
    );
  }
}