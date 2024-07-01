import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterSurveyEtcInputState extends StateNotifier<String> {
  RegisterSurveyEtcInputState() : super("");

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}

final registerSurveyEtcInputProvider = 
    StateNotifierProvider<RegisterSurveyEtcInputState, String>((ref) => RegisterSurveyEtcInputState());