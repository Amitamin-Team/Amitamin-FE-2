import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterVerificationCodeButtonState extends StateNotifier<bool> {
  RegisterVerificationCodeButtonState() : super(false);

  void set(bool value) {
    state = value;
  }

  bool get() {
    return state;
  }

  void activate(String nickname) {
    if(nickname.isEmpty) {
      state = false;
    } else {
      state = true;
    }
  }
}

final registerVerificationCodeButtonProvider = 
    StateNotifierProvider<RegisterVerificationCodeButtonState, bool>((ref) => RegisterVerificationCodeButtonState());