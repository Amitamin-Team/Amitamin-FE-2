import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginEmailInputState extends StateNotifier<String> {
  LoginEmailInputState() : super("");

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}