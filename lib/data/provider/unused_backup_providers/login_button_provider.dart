import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginButtonState extends StateNotifier<bool> {
  LoginButtonState() : super(false);

  void activate(String email, String password) {
    if(email.isNotEmpty && password.isNotEmpty) {
      state = true;
    } else {
      state = false;
    }
  }
}

final loginButtonProvider = 
  StateNotifierProvider<LoginButtonState, bool>((ref) => LoginButtonState());