import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPasswordInputState extends StateNotifier<String> {
  LoginPasswordInputState() : super("");

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}

final loginPasswordInputProvider = 
    StateNotifierProvider<LoginPasswordInputState, String>((ref) => LoginPasswordInputState());