import 'package:amitamin_frontend/controller/controller.dart';
import 'package:amitamin_frontend/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestRegisterState extends StateNotifier<RequestRegisterModel> {
  RequestRegisterState() : super(
    RequestRegisterModel(
      email: '',
      password: '',
      nickname: '',
      sex: '',
      birth: '',
      private_yn: '',
      survey_summary: '',
    )
  );

  void set(RequestRegisterModel requestRegisterModel) {
    state = requestRegisterModel;
  }

  RequestRegisterModel get() {
    return state;
  }

  Future<void> setValue(dynamic value, String tag) async {
    if(tag == RegisterController.EMAIL)    state = state.copyWith(email: value);
    if(tag == RegisterController.PASSWD)   state = state.copyWith(password: value);
    if(tag == RegisterController.NICKNAME) state = state.copyWith(nickname: value);
    if(tag == RegisterController.SEX)      state = state.copyWith(sex: value);
    if(tag == RegisterController.BIRTH)    state = state.copyWith(birth: value);
    if(tag == RegisterController.PRIVATE)  state = state.copyWith(private_yn: value);
    if(tag == RegisterController.SURVEY)   state = state.copyWith(survey_summary: value);
  }

  Future<void> setValues({String? email, String? password, String? nickname, String? sex, String? birth, String? private_yn, String? survey_summary}) async {
    state = state.copyWith(
      email: email,
      password: password,
      nickname: nickname,
      sex: sex,
      birth: birth,
      private_yn: private_yn,
      survey_summary: survey_summary
    );
  }
}