import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterSexButtonState extends StateNotifier<String> {
  RegisterSexButtonState() : super("");

  void set(String sex) {
    state = sex;
  }

  String get() {
    return state;
  }
}