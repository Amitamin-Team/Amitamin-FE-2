import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:amitamin_frontend/common/common.dart';

class MySubMenuContainer extends StatelessWidget {
  const MySubMenuContainer({
    Key? key,
    required this.menuName,
    required this.svgPath,
    required this.svgFlag,
    this.widget,
    required this.voidCallback,
  }) : super(key: key);

  final String menuName;
  final String svgPath;
  final bool svgFlag;
  final Widget? widget;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColor.white,
      child: InkWell(
        onTap: voidCallback,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 56,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  menuName,
                  style: TextStyle(
                      color: CustomColor.black,
                      fontSize: CustomText.body3.fontSize,
                      fontFamily: CustomText.body3.fontFamily,
                      fontWeight: CustomText.body3.fontWeight),
                ),
                const Spacer(),
                svgFlag
                    ? SvgPicture.asset(
                        svgPath,
                        width: 24,
                        height: 24,
                      )
                    : widget ?? const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
