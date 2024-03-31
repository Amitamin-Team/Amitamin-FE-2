import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivateRadioState extends StateNotifier<bool> {
  PrivateRadioState() : super(false);

  void toggle() {
    state = !state;
  }

  bool get() {
    return state;
  }
}

final privateRadioProvider = StateNotifierProvider<PrivateRadioState, bool>((ref) => PrivateRadioState());