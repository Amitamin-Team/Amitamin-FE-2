import 'package:flutter_riverpod/flutter_riverpod.dart';

class SurveyRadioState extends StateNotifier<String> {
  SurveyRadioState() : super("");

  void setState(String value) {
    state = value;
  }
}

final surveyRadioProvider = StateNotifierProvider<SurveyRadioState, String>((ref) => SurveyRadioState());