import 'package:amitamin_frontend/common/common.dart';
import 'package:amitamin_frontend/data/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTabViewItem extends ConsumerWidget {
  const HomeTabViewItem({
    Key? key,
    this.objectType,
    required this.objectItmes
  }) : super(key: key);

  final String? objectType;
  final List<Widget> objectItmes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: objectItmes.isNotEmpty ? 
                objectItmes :
                [
                  const SizedBox(height: 108,),
                  SvgPicture.asset(
                    'assets/icons/system/ballon.svg',
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(height: 12,),
                  Text(
                    "아직 목표가 없어요!",
                    style: TextStyle(
                      fontSize: CustomText.headLine7.fontSize,
                      fontWeight: CustomText.headLine7.fontWeight,
                      fontFamily: CustomText.headLine7.fontFamily,
                      color: CustomColor.extraDarkGray,
                    ),
                  ),
                  const SizedBox(height: 108,),
                ]
    );
  }
}