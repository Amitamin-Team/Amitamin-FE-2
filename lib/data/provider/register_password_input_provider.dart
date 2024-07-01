import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPasswordInputState extends StateNotifier<String> {
  RegisterPasswordInputState() : super("");

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}

final registerPasswordInputProvider = 
    StateNotifierProvider<RegisterPasswordInputState, String>((ref) => RegisterPasswordInputState());