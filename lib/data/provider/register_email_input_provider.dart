import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterEmailInputState extends StateNotifier<String> {
  RegisterEmailInputState() : super("");

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}

final registerEmailInputProvider = 
    StateNotifierProvider<RegisterEmailInputState, String>((ref) => RegisterEmailInputState());