import 'package:amitamin_frontend/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterModelState extends StateNotifier<RequestRegisterModel> {
  RegisterModelState() : super(
    RequestRegisterModel(
      nickname: "",
      sex: "",
      birth: "",
      email: "",
      password: "",
      private_yn: "",
      survey_summary: "",
    )
  );

  void set(RequestRegisterModel requestRegisterModel) {
    state = requestRegisterModel;
  }

  RequestRegisterModel get() {
    return state;
  }

  void setNickname(String nickname) {
    state = RequestRegisterModel(
      nickname: nickname, 
      sex: state.sex, 
      birth: state.birth, 
      email: state.email, 
      password: state.password, 
      private_yn: state.private_yn, 
      survey_summary: state.survey_summary);
  }

  void setGender(String sex) {
    state = RequestRegisterModel(
      nickname: state.nickname, 
      sex: sex, 
      birth: state.birth, 
      email: state.email, 
      password: state.password, 
      private_yn: state.private_yn, 
      survey_summary: state.survey_summary);
  }

  void setBirth(String birth) {
    state = RequestRegisterModel(
      nickname: state.nickname, 
      sex: state.sex, 
      birth: birth, 
      email: state.email, 
      password: state.password, 
      private_yn: state.private_yn, 
      survey_summary: state.survey_summary);
  }

  void setEmail(String email) {
    state = RequestRegisterModel(
      nickname: state.nickname, 
      sex: state.sex, 
      birth: state.birth, 
      email: email, 
      password: state.password, 
      private_yn: state.private_yn, 
      survey_summary: state.survey_summary);
  }

  void setPassword(String password) {
    state = RequestRegisterModel(
      nickname: state.nickname, 
      sex: state.sex, 
      birth: state.birth, 
      email: state.email, 
      password: password, 
      private_yn: state.private_yn, 
      survey_summary: state.survey_summary);
  }

  void setPrivateYN(String private_yn) {
    state = RequestRegisterModel(
      nickname: state.nickname, 
      sex: state.sex, 
      birth: state.birth, 
      email: state.email, 
      password: state.password, 
      private_yn: private_yn, 
      survey_summary: state.survey_summary);
  }

  void setSurvey(String survey_summary) {
    state = RequestRegisterModel(
      nickname: state.nickname, 
      sex: state.sex, 
      birth: state.birth, 
      email: state.email, 
      password: state.password, 
      private_yn: state.private_yn, 
      survey_summary: survey_summary);
  }
}

final registerModelProvider = 
  StateNotifierProvider<RegisterModelState, RequestRegisterModel>((ref) => RegisterModelState());