import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerificationCodeButtonState extends StateNotifier<bool> {
  VerificationCodeButtonState() : super(false);

  void activate(String code) {
    if(code.isNotEmpty) {
      state = true;
    } else {
      state = false;
    }
  }
}

final verificationCodeButtonProvider = 
  StateNotifierProvider<VerificationCodeButtonState, bool>((ref) => VerificationCodeButtonState());