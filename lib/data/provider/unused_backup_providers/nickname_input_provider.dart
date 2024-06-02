import 'package:flutter_riverpod/flutter_riverpod.dart';

class NicknameInputState extends StateNotifier<String> {
  NicknameInputState() : super("init");

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }

  String validate(String nickname) {
    state = "pass_valid"; // dio 요청이 완료된 경우 : pass_all
    
    if(nickname.isEmpty) {
      state = "no_data";
    } else if(nickname.length > 8) {
      state = "invalid_length";
    }

    return state;
  }

  bool getValidBoolState() {
    return (state != "pass_valid" && 
           state != "pass_all" && 
           state != "init") ? true : false;
  }
}

final nicknameInputProvider = 
  StateNotifierProvider<NicknameInputState, String>((ref) => NicknameInputState());