import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailInputState extends StateNotifier<String> {
  EmailInputState() : super("init");

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
    } else if(!checkEmailFormat(email)) {
      state = "invalid_format";
    }

    return state;
  }

  bool getValidBoolState() {
    return (state != "pass_valid" && 
            state != "pass_all" && 
            state != "init") ? true : false;
  }

  bool getVisibleCodeContentState() {
    // TODO : pass_valid는 추후에 제외해야 함
    return (state == "pass_valid" || 
            state == "pass_all" ||
            state == "already_certified") ? true : false;
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