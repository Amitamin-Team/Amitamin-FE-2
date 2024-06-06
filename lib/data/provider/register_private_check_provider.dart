import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPrivateCheckState extends StateNotifier<String> {
  RegisterPrivateCheckState() : super("N");

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}