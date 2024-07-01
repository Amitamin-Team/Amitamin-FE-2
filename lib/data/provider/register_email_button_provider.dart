import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterEmailButtonState extends StateNotifier<bool> {
  RegisterEmailButtonState() : super(false);

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

final registerEmailButtonProvider = 
    StateNotifierProvider<RegisterEmailButtonState, bool>((ref) => RegisterEmailButtonState());