import 'package:flutter_riverpod/flutter_riverpod.dart';

class BirthInputState extends StateNotifier<String> {
  BirthInputState() : super("init");

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }

  String validate(String birth) {
    state = "pass_all";
    
    if(birth.isEmpty) {
      state = "no_data";
    } else if(birth.length != 10) {
      state = "invalid_length";
    }

    return state;
  }

  bool getValidBoolState() {
    return (state != "pass_all" && 
            state != "init") ? true : false;
  }
}

final birthInputProvider = 
  StateNotifierProvider<BirthInputState, String>((ref) => BirthInputState());