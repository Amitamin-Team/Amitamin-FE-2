import 'package:amitamin_frontend/common/common.dart';
import 'package:amitamin_frontend/data/provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void fnInitRegisterProviders(WidgetRef ref, String screen) {
  if(screen == "1") {
    fnInitRegisterFirstScreenProviders(ref);
  } else if(screen == "2") {
    fnInitRegisterSecondScreenProviders(ref);
  } else if(screen == "3") {
    fnInitRegisterThirdScreenProviders(ref);
  } else if(screen == "all") {
    fnInitRegisterFirstScreenProviders(ref);
    fnInitRegisterSecondScreenProviders(ref);
    fnInitRegisterThirdScreenProviders(ref);
  }
  
  ref.invalidate(registerModelProvider);
}

void fnInitRegisterFirstScreenProviders(WidgetRef ref) {
    ref.invalidate(nicknameButtonProvider);
    ref.invalidate(nicknameInputProvider);
    ref.invalidate(genderButtonProvider);
    ref.invalidate(birthInputProvider);
    ref.invalidate(privateRadioProvider);
}

void fnInitRegisterSecondScreenProviders(WidgetRef ref) {
    ref.invalidate(emailButtonProvider);
    ref.invalidate(emailInputProvider);
    ref.invalidate(verificationCodeButtonProvider);
    ref.invalidate(verificationCodeInputProvider);
    ref.invalidate(passwordInputProvider);
}

void fnInitRegisterThirdScreenProviders(WidgetRef ref) {
    ref.invalidate(surveyRadioProvider);
}

bool validateNickname(WidgetRef ref, BuildContext context, String nickname) {
    bool result = false;

    // 닉네임 유효성 검증
    String verifyNicknameInputResult = ref.read(nicknameInputProvider.notifier).validate(
      nickname,
    );

    // TODO : 닉네임 중복확인 후 pass_all, 추후에 pass_valid 제외시켜야 함
    if(verifyNicknameInputResult == "pass_all" || verifyNicknameInputResult == "pass_valid") {
      ref.read(registerModelProvider.notifier).setNickname(nickname);
      result = true;
    } 
    if(verifyNicknameInputResult == "no_data") {
      showAlertDialog(context: context, middleText: "닉네임을 입력해주세요.");
    }
    if(verifyNicknameInputResult == "length_over_8") {
      showAlertDialog(context: context, middleText: "닉네임은 최대 8글자까지 입력할 수 있어요.");
    }
    /*if(verifyNicknameInputResult == "pass_valid") {
      showAlertDialog(context: context, middleText: "닉네임 중복확인을 해주세요.");
    }*/
    if(verifyNicknameInputResult == "duplicated") {
      showAlertDialog(context: context, middleText: "중복된 닉네임이 있어요.");
    }

    return result;
}

bool validateSex(WidgetRef ref, BuildContext context, String sex) {
    bool result = false;
    
    if(sex != "") {
      ref.read(registerModelProvider.notifier).setGender(sex);
      result = true;
    } else {
      showAlertDialog(context: context, middleText: "성별을 선택해주세요.");
    }

    return result;
}

bool validateBirth(WidgetRef ref, BuildContext context, String birth) {
    bool result = false;

    // 생년월일 유효성 검증
    String verifyBirthInputResult = ref.read(birthInputProvider.notifier).validate(birth);

    if(verifyBirthInputResult == "pass_all") {
      // 19900101 -> 1990-01-01
      // String formatBirth = "${birthInputController.text.substring(0, 4)}-${birthInputController.text.substring(4, 6)}-${birthInputController.text.substring(6)}";
      
      ref.read(registerModelProvider.notifier).setBirth(birth);
      result = true;
    }
    if(verifyBirthInputResult == "no_data") {
      showAlertDialog(context: context, middleText: "생년월일을 입력해주세요.");
    }
    if(verifyBirthInputResult == "invalid_length") {
      showAlertDialog(context: context, middleText: "생년월일을 정확히 입력해주세요.");
    }

    return result;
}

bool validatePrivateYn(WidgetRef ref, BuildContext context, bool private_yn) {
    bool result = false;

    // 개인정보 처리 방침 동의 검증
    if(private_yn) {
      ref.read(registerModelProvider.notifier).setPrivateYN("Y");
      result = true;
    } else {
      showAlertDialog(context: context, middleText: "개인정보 처리 방침에 동의해주세요.");
    }

    return result;
}

bool validateEmail(WidgetRef ref, BuildContext context, String email) {
    bool result = false;

    // 유효성 검증
    String verifyEmailInputResult = ref.watch(emailInputProvider.notifier).validate(email);

    if(verifyEmailInputResult == "pass_valid") {
      result = true;
    }
    if(verifyEmailInputResult == "no_data") {
      showAlertDialog(context: context, middleText: "이메일을 입력해주세요.");
    }
    if(verifyEmailInputResult == "invalid_format") {
      showAlertDialog(context: context, middleText: "올바른 이메일 형식이 아닙니다.");
    }

    return result;
}

bool validateCode(WidgetRef ref, BuildContext context, String code, String email) {
    bool result = false;

    String verifyCodeInputResult = ref.read(verificationCodeInputProvider.notifier).validate(code);

    // TODO : 인증번호 확인 후 pass_all, 추후에 pass_valid 제외시켜야 함
    if(verifyCodeInputResult == "pass_all" || verifyCodeInputResult == "pass_valid") {
      ref.read(registerModelProvider.notifier).setEmail(email);
      result = true;
    } 
    if(verifyCodeInputResult == "no_data") {
      showAlertDialog(context: context, middleText: "인증번호를 입력해주세요.");
    }
    /*if(verifyCodeInputResult == "pass_valid") {
      showAlertDialog(context: context, middleText: "인증번호 인증확인을 해주세요.");
    }*/
    if(verifyCodeInputResult == "invalid_code") {
      showAlertDialog(context: context, middleText: "인증번호가 맞지 않아요.");
    }

    return result;
}

bool validatePassword(WidgetRef ref, BuildContext context, String password, String passwordConfirm) {
    bool result = false;

    // 비밀번호 유효성 검증
    String verfiyPasswordInputResult = ref.watch(passwordInputProvider.notifier).validate(
      password, passwordConfirm
    );
    
    if(verfiyPasswordInputResult == "pass_all") {
      ref.read(registerModelProvider.notifier).setPassword(password);
      result = true;
    }
    if(verfiyPasswordInputResult == "no_data") {
      showAlertDialog(context: context, middleText: "비밀번호를 입력해주세요.");
    }
    if(verfiyPasswordInputResult == "invalid_length") {
      showAlertDialog(context: context, middleText: "비밀번호를\n8-15자 사이로 입력해 주세요.");
    }
    if(verfiyPasswordInputResult == "not_matched") {
      showAlertDialog(context: context, middleText: "비밀번호가 맞지 않아요.");
    }

    return result;
}

bool validateSurvey(WidgetRef ref, BuildContext context, String survey_summary, String etc) {
    bool result = false;

    if(survey_summary == "") {
      showAlertDialog(context: context, middleText: "가입설문 내용을 선택해주세요.");
    } else if (survey_summary == "4") {
      if(etc.isEmpty) {
        showAlertDialog(context: context, middleText: "기타의 내용을 입력해주세요.");
      } else {
        survey_summary += ", $etc";
        ref.read(registerModelProvider.notifier).setSurvey(survey_summary);
        result = true;
      }
    } else {
      ref.read(registerModelProvider.notifier).setSurvey(survey_summary);
      result = true;
    }

    return result;
}

