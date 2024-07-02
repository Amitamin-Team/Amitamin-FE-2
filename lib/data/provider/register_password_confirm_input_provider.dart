import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPasswordConfirmInputState extends StateNotifier<String> {
  RegisterPasswordConfirmInputState() : super("");

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}

final registerPasswordConfirmInputProvider = 
    StateNotifierProvider<RegisterPasswordConfirmInputState, String>((ref) => RegisterPasswordConfirmInputState());