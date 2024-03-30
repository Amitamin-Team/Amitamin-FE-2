import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailButtonState extends StateNotifier<bool> {
  EmailButtonState() : super(false);

  void activate(String email) {
    if(email.isNotEmpty) {
      state = true;
    } else {
      state = false;
    }
  }
}

final emailButtonProvider = 
  StateNotifierProvider<EmailButtonState, bool>((ref) => EmailButtonState());