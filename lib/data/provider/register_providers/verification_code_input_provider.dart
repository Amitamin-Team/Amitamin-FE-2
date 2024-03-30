import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerificationCodeInputState extends StateNotifier<String> {
  VerificationCodeInputState() : super("init");

  void setState(String value) {
    state = value;
  }

  String validate(String email) {
    state = "pass";
    
    if(email.isEmpty) {
      state = "no_data";
    }

    return state;
  }
}

final verificationCodeInputProvider = 
  StateNotifierProvider<VerificationCodeInputState, String>((ref) => VerificationCodeInputState());