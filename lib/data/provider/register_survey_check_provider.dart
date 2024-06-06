import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterSurveyCheckState extends StateNotifier<String> {
  RegisterSurveyCheckState() : super("");

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}