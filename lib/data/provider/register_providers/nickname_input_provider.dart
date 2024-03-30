import 'package:flutter_riverpod/flutter_riverpod.dart';

class NicknameInputState extends StateNotifier<String> {
  NicknameInputState() : super("init");

  String validate(String nickname) {
    state = "pass";
    
    if(nickname.isEmpty) {
      state = "no_data";
    } else if(nickname.length > 8) {
      state = "length_over_8";
    }

    return state;
  }
}

final nicknameInputProvider = 
  StateNotifierProvider<NicknameInputState, String>((ref) => NicknameInputState());