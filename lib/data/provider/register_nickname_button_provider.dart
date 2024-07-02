import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterNicknameButtonState extends StateNotifier<bool> {
  RegisterNicknameButtonState() : super(false);

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

final registerNicknameButtonProvider = 
    StateNotifierProvider<RegisterNicknameButtonState, bool>((ref) => RegisterNicknameButtonState());