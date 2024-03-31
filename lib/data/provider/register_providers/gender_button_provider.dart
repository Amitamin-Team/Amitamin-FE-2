import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenderButtonState extends StateNotifier<String> {
  GenderButtonState() : super("");

  void set(String gender) {
    state = gender;
  }

  String get() {
    return state;
  }
}

final genderButtonProvider = 
  StateNotifierProvider<GenderButtonState, String>((ref) => GenderButtonState());