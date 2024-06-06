import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterBirthInputState extends StateNotifier<String> {
  RegisterBirthInputState() : super("");

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}