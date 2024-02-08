import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTabState extends StateNotifier<int> {
  HomeTabState() : super(0);

  void changeHomeTabIndex(int value) {
    state = value;
  }
}

final homeTabProvider = 
  StateNotifierProvider<HomeTabState, int>((ref) => HomeTabState());