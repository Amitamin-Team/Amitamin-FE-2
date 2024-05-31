import 'package:flutter_riverpod/flutter_riverpod.dart';

final fatigueScoreProvider = StateNotifierProvider<FatigueScore, double>((ref) => FatigueScore());

class FatigueScore extends StateNotifier<double> {
  FatigueScore() : super(0.0);

  void setScore(double score) => state = score;
}