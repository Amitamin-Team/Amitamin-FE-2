import 'package:amitamin_frontend/controller/home_fatigue_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:amitamin_frontend/common/common.dart';

class HomeSelectSurveyScreen extends ConsumerStatefulWidget {
  const HomeSelectSurveyScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeSelectSurveyScreen> createState() => HomeSelectSurveyScreenState();
}

class HomeSelectSurveyScreenState extends ConsumerState<HomeSelectSurveyScreen> {
  @override
  Widget build(BuildContext context) {
    
    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '목표리스트 추가',
        leadingDisable: false,
        leadingOnPressed: () async {
          if (!context.mounted) return;
          context.pop();
        },
        actionDisable: true,
      ),
      child: WillPopScope(
        onWillPop: () async {
          if (!context.mounted) return false;
          context.pop();
          
          return false;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '설문지 유형 선택',
                    style: CustomText.headLine4,
                  ),
                  const SizedBox(height: 6,),
                  Text(
                    '설문지 작성을 통해 구체적인 목표를 추천해드려요',
                    style: TextStyle(
                      color: CustomColor.extraDarkGray,
                      fontFamily: CustomText.body4.fontFamily,
                      fontSize: CustomText.body4.fontSize,
                      fontWeight: CustomText.body4.fontWeight,
                    ),
                  ),
                  const SizedBox(height: 12,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}