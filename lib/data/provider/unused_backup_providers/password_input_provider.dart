import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordInputState extends StateNotifier<String> {
  PasswordInputState() : super("init");

  void setState(String value) {
    state = value;
  }

  String validate(String password, String confirmPassword) {
    state = "pass_all"; // dio 요청이 필요없는 로직 : pass_all
    
    if(password.isEmpty) {
      state = "no_data";
    } else if(password.length < 8 || password.length > 15) {
      state = "invalid_length";
    } else if(password != confirmPassword) {
      state = "not_matched";
    }

    return state;
  }

  bool getValidBoolState() {
    return (state != "pass_all" && 
            state != "init" &&
            state != "not_matched") ? true : false;
  }
}

final passwordInputProvider = 
  StateNotifierProvider<PasswordInputState, String>((ref) => PasswordInputState());