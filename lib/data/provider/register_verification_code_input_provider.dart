import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterVerificationCodeInputState extends StateNotifier<String> {
  RegisterVerificationCodeInputState() : super("");

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}