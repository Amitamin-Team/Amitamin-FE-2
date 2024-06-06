import 'package:amitamin_frontend/common/common.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterBirthInputResultState extends StateNotifier<String> {
  RegisterBirthInputResultState() : super(ProjectConstant.INPUT_CODE_00);

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}