import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordInputState extends StateNotifier<String> {
  PasswordInputState() : super("init");

  void setState(String value) {
    state = value;
  }

  String validate(String password, String confirmPassword) {
    state = "pass";
    
    if(password.isEmpty) {
      state = "no_data";
    } else if(password.length < 8 || password.length > 15) {
      state = "invalid_length";
    } else if(password != confirmPassword) {
      state = "not_matched";
    }

    return state;
  }
}

final passwordInputProvider = 
  StateNotifierProvider<PasswordInputState, String>((ref) => PasswordInputState());