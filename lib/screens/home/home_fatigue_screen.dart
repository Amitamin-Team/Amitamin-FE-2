import 'package:amitamin_frontend/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:amitamin_frontend/common/common.dart';

class HomeFatigueScreen extends ConsumerStatefulWidget {
  const HomeFatigueScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeFatigueScreen> createState() => HomeFatigueScreenState();
}

class HomeFatigueScreenState extends ConsumerState<HomeFatigueScreen> {
  @override
  Widget build(BuildContext context) {
    final fatigueScoreState = ref.watch(fatigueScoreProvider);

    final sliderWidth = MediaQuery.of(context).size.width;

    int score = (fatigueScoreState/(sliderWidth-60)*10).round();

    // TODO : 점수를 체크하지 않았으면 화면 진입, slider 활성화
    // TODO : 점수가 체크되어 있으면 화면 진입, 점수 세팅, slider 비활성화

    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '피로도 체크하기',
        leadingDisable: false,
        leadingOnPressed: () async {
          await fnInvalidate(ref, fatigueScoreProvider);
          if (!context.mounted) return;
          context.pop();
        },
        actionDisable: true,
      ),
      child: WillPopScope(
        onWillPop: () async {
          await fnInvalidate(ref, fatigueScoreProvider);
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
                  Text(
                    DateFormat('yyyy.MM.dd (E)','ko_KR').format(DateTime.now()),
                    style: TextStyle(
                      color: CustomColor.primaryBlue100,
                      fontSize: CustomText.body6.fontSize,
                      fontWeight: CustomText.body3.fontWeight,
                      fontFamily: CustomText.body6.fontFamily,
                    ),
                  ),
                  const SizedBox(height: 12,),
                  const Text(
                    '일일 피로 자가 체크',
                    style: CustomText.headLine4,
                  ),
                  const SizedBox(height: 6,),
                  Text(
                    '오늘 하루 피로도를 체크해주세요!',
                    style: TextStyle(
                      color: CustomColor.gray,
                      fontFamily: CustomText.body6.fontFamily,
                      fontSize: CustomText.body6.fontSize,
                      fontWeight: CustomText.body6.fontWeight,
                    ),
                  ),
                  const SizedBox(height: 12,),
                  SizedBox(
                    height: 282,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              ProjectConstant.FATIGUE_SCORE_MAP[score]!['path']!,
                              width: 60,
                              height: 60,
                            ),
                            const SizedBox(height: 8,),
                            Text(
                              // '${(fatigueScoreState/(sliderWidth-60)*10).round()}점',
                              '${ProjectConstant.FATIGUE_SCORE_MAP[score]!['score']!}점',
                              style: CustomText.headLine4,
                            ),
                            const SizedBox(height: 8,),
                            Text(
                              '몇점입니다.',
                              style: TextStyle(
                                color: CustomColor.gray,
                                fontFamily: CustomText.body6.fontFamily,
                                fontSize: CustomText.body6.fontSize,
                                fontWeight: CustomText.body6.fontWeight,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 34,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              for(int i=0;i<10;i++)
                                Container(
                                  height: 16,
                                  width: (sliderWidth - 60) / 10,
                                  margin: EdgeInsets.only(top: 9, right: (i < 9) ? 2.0 : 0.0),
                                  decoration: BoxDecoration(
                                    borderRadius: i == 0 ?
                                      const BorderRadius.only(topLeft: Radius.circular(16.0), bottomLeft: Radius.circular(16.0)) :
                                      i == 9 ?
                                        const BorderRadius.only(topRight: Radius.circular(16.0), bottomRight: Radius.circular(16.0)) :
                                        BorderRadius.circular(0.0),
                                    color: const Color(0xffE0E0E0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              for(int i=0;i<10;i++)
                                Container(
                                  height: 16,
                                  // TODO : 점수 체크 여부에 따라 slider on/off
                                  width: (fatigueScoreState - ((sliderWidth - 60) / 10) * i).clamp(0, ((sliderWidth - 60) / 10)),
                                  margin: EdgeInsets.only(top: 9, right: (i < 9) ? 2.0 : 0.0),
                                  decoration: BoxDecoration(
                                    borderRadius: i == 0 ?
                                    const BorderRadius.only(topLeft: Radius.circular(16.0), bottomLeft: Radius.circular(16.0)) :
                                    i == 9 ?
                                    const BorderRadius.only(topRight: Radius.circular(16.0), bottomRight: Radius.circular(16.0)) :
                                    BorderRadius.circular(0.0),
                                    color: i < 4 ? const Color(0xffFFF174) :
                                           i < 6 ? const Color(0xffC8FE83) :
                                           i < 7 ? const Color(0xffADEC5C) :
                                           i < 8 ? const Color(0xffFF9B39) :
                                           i < 9 ? const Color(0xffEF703A) :
                                           const Color(0xffEF703A),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Positioned(
                          // 점수 체크 여부에 따라 pointer on/off
                          left: fatigueScoreState - 5,
                          top: 0,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              ref.read(fatigueScoreProvider.notifier)
                                 .setScore((details.delta.dx + fatigueScoreState)
                                 .clamp(0, sliderWidth-59));
                            },
                            child: SvgPicture.asset(
                              'assets/icons/home/slider_button.svg',
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '0',
                        style: TextStyle(
                          color: CustomColor.gray,
                          fontFamily: CustomText.body6.fontFamily,
                          fontSize: CustomText.body6.fontSize,
                          fontWeight: CustomText.body6.fontWeight,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '10',
                        style: TextStyle(
                          color: CustomColor.gray,
                          fontFamily: CustomText.body6.fontFamily,
                          fontSize: CustomText.body6.fontSize,
                          fontWeight: CustomText.body6.fontWeight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 34,),
                  /*GrayTextButton(
                    disabled: (score/(width-60)*10).round() > 0 ? false : true,
                    text: '완료',
                  ),*/
                  const SizedBox(height: 16,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getFatigueState(int score) {
     switch(score) {
       case 0:
         return 'assets/icons/state/state=0.svg';
       case 1:
         return 'assets/icons/state/state=1.svg';
       case 2:
         return 'assets/icons/state/state=2.svg';
       case 3:
         return 'assets/icons/state/state=3.svg';
       case 4:
         return 'assets/icons/state/state=4.svg';
       case 5:
         return 'assets/icons/state/state=5.svg';
       case 6:
         return 'assets/icons/state/state=6.svg';
       case 7:
         return 'assets/icons/state/state=7.svg';
       case 8:
         return 'assets/icons/state/state=8.svg';
       case 9:
         return 'assets/icons/state/state=9.svg';
       case 10:
         return 'assets/icons/state/state=10.svg';
       default:
         return 'assets/icons/state/state=0.svg';
     }
  }
}