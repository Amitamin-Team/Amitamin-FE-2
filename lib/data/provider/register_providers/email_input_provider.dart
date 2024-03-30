import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailInputState extends StateNotifier<String> {
  EmailInputState() : super("init");

  void setState(String value) {
    state = value;
  }

  String validate(String email) {
    state = "pass";
    
    if(email.isEmpty) {
      state = "no_data";
    } else if(!checkEmailFormat(email)) {
      state = "invalid_format";
    }

    return state;
  }
}

bool checkEmailFormat(String email) {
  bool result = true;

  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);

  if(!regExp.hasMatch(email)) {
    result = false;
  }

  return result;
}

final emailInputProvider = 
  StateNotifierProvider<EmailInputState, String>((ref) => EmailInputState());