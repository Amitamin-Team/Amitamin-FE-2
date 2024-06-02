import 'package:flutter_riverpod/flutter_riverpod.dart';

class SurveyRadioState extends StateNotifier<String> {
  SurveyRadioState() : super("");

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}

final surveyRadioProvider = StateNotifierProvider<SurveyRadioState, String>((ref) => SurveyRadioState());