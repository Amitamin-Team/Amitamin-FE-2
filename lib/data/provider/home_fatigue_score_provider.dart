import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeFatigueScore extends StateNotifier<double> {
  HomeFatigueScore() : super(0.0);

  void set(double score) => state = score;

  double get() => state;
}