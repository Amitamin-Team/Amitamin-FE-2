import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterEmailButtonPressedState extends StateNotifier<bool> {
  RegisterEmailButtonPressedState() : super(false);

  void set(bool value) {
    state = value;
  }

  bool get() {
    return state;
  }
}