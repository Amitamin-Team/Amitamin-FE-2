import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeFatigueScoreState extends StateNotifier<double> {
  HomeFatigueScoreState() : super(0.0);

  void set(double score) => state = score;

  double get() => state;
}