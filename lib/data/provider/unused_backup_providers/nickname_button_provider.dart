import 'package:flutter_riverpod/flutter_riverpod.dart';

class NicknameButtonState extends StateNotifier<bool> {
  NicknameButtonState() : super(false);

  void activate(String nickname) {
    if(nickname.isNotEmpty) {
      state = true;
    } else {
      state = false;
    }
  }
}

final nicknameButtonProvider = 
  StateNotifierProvider<NicknameButtonState, bool>((ref) => NicknameButtonState());