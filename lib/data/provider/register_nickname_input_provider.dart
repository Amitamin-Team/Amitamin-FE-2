import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterNicknameInputState extends StateNotifier<String> {
  RegisterNicknameInputState() : super("");

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}

final registerNicknameInputProvider = 
    StateNotifierProvider<RegisterNicknameInputState, String>((ref) => RegisterNicknameInputState());