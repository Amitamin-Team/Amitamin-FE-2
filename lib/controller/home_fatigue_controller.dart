import 'package:amitamin_frontend/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeFatigueController {
  static final List<HomeFatigueScoreModel> fatigueScoreList = [
    HomeFatigueScoreModel(
      score: 0,
      imgPath: 'assets/icons/emoji/state=0.svg',
      comment: '전혀 피로하지 않고 몸과 마음이 최상의 컨디션이에요',
    ),
    HomeFatigueScoreModel(
      score: 1,
      imgPath: 'assets/icons/emoji/state=1.svg',
      comment: '일 또는 일상생활 활동에 대한 흥미나 동기가 높은 상태에요\n피로감이 거의 느껴지지 않아요',
    ),
    HomeFatigueScoreModel(
      score: 2,
      imgPath: 'assets/icons/emoji/state=2.svg',
      comment: '피로감이 거의 없고 몸이 가볍고 마음도 긍정적인 상태에요',
    ),
    HomeFatigueScoreModel(
      score: 3,
      imgPath: 'assets/icons/emoji/state=3.svg',
      comment: '약간의 피로감이 느껴지지만 일을 하는 데에 전혀 문제가 없어요',
    ),
    HomeFatigueScoreModel(
      score: 4,
      imgPath: 'assets/icons/emoji/state=4.svg',
      comment: '약간의 피로감으로 낮 동안 졸음이 오기도 해요\n약간의 피로감이 있고 생각이나 행동이 약간 느려지는 듯한 느낌이에요',
    ),
    HomeFatigueScoreModel(
      score: 5,
      imgPath: 'assets/icons/emoji/state=5.svg',
      comment: '피로감이 느껴지고 일 또는 일상생활 활동에 대한 흥미나 동기가 낮아요\n약간의 피로감이 느껴지고 무언가 시작하는 데에 노력이 필요해요',
    ),
    HomeFatigueScoreModel(
      score: 6,
      imgPath: 'assets/icons/emoji/state=6.svg',
      comment: '피로감으로 인한 신체적 증상이 나타나거나 기분이 저하된 상태에요\n피로감이 있어 전반적으로 무기력한 상태에요',
    ),
    HomeFatigueScoreModel(
      score: 7,
      imgPath: 'assets/icons/emoji/state=7.svg',
      comment: '피로감이 오래 지속되고 휴식이 필요해요',
    ),
    HomeFatigueScoreModel(
      score: 8,
      imgPath: 'assets/icons/emoji/state=8.svg',
      comment: '피로감이 매우 높아 일상생활 또는 일을 유지하기가 어려워요',
    ),
    HomeFatigueScoreModel(
      score: 9,
      imgPath: 'assets/icons/emoji/state=9.svg',
      comment: '휴식을 취해도 피로가 회복되지 않고 매우 지쳐 신경질도 나요',
    ),
    HomeFatigueScoreModel(
      score: 10,
      imgPath: 'assets/icons/emoji/state=10.svg',
      comment: '전혀 움직일 수 없고 혼자서 이겨낼 수 없는 정도의 피로를 느껴요',
    ),
  ];

  static final homeFatigueScoreProvider = StateNotifierProvider<HomeFatigueScoreState, double>((ref) => HomeFatigueScoreState());
}