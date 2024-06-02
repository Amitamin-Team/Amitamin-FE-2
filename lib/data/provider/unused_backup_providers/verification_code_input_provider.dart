import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerificationCodeInputState extends StateNotifier<String> {
  VerificationCodeInputState() : super("init");

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }

  String validate(String email) {
    state = "pass_valid";
    
    if(email.isEmpty) {
      state = "no_data";
    }

    return state;
  }

  bool getValidBoolState() {
    return (state != "pass_valid" && 
            state != "pass_all" && 
            state != "init") ? true : false;
  }
}

final verificationCodeInputProvider = 
  StateNotifierProvider<VerificationCodeInputState, String>((ref) => VerificationCodeInputState());