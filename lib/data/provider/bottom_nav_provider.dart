import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavState extends StateNotifier<int> {
  BottomNavState() : super(0);

  void changeBottomNavIndex(int value) {
    state = value;
  }
}

final bottomNavProvider = 
  StateNotifierProvider<BottomNavState, int>((ref) => BottomNavState());