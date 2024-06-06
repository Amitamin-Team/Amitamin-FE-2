import 'package:amitamin_frontend/common/common.dart';
import 'package:amitamin_frontend/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterController {
  /* 회원가입 관련 태그 */
  static const NICKNAME = 'nickname';
  static const SEX = 'sex';
  static const BIRTH = 'birth';
  static const PRIVATE = 'private_yn';
  static const EMAIL = 'email';
  static const CODE = 'code';
  static const PASSWD = 'password';
  static const SURVEY = 'survey_summary';


  /* ########## 회원가입 관련 Provider ########## */
  /* 회원가입 첫 번째 화면 Provider */
  static final registerNicknameInputProvider = 
    StateNotifierProvider<RegisterNicknameInputState, String>((ref) => RegisterNicknameInputState());
  
  static final registerNicknameInpuResultProvider = 
    StateNotifierProvider<RegisterNicknameInputResultState, String>((ref) => RegisterNicknameInputResultState());

  static final registerNicknameButtonProvider = 
    StateNotifierProvider<RegisterNicknameButtonState, bool>((ref) => RegisterNicknameButtonState());

  static final registerSexButtonProvider = 
    StateNotifierProvider<RegisterSexButtonState, String>((ref) => RegisterSexButtonState());

  static final registerBirthInputProvider =
    StateNotifierProvider<RegisterBirthInputState, String>((ref) => RegisterBirthInputState());

  static final registerBirthInputResultProvider =
    StateNotifierProvider<RegisterBirthInputResultState, String>((ref) => RegisterBirthInputResultState());

  static final registerPrivateCheckProvider = 
    StateNotifierProvider<RegisterPrivateCheckState, String>((ref) => RegisterPrivateCheckState());

  /* 회원가입 두 번째 화면 Provider */
  static final registerEmailInputProvider = 
    StateNotifierProvider<RegisterEmailInputState, String>((ref) => RegisterEmailInputState());

  static final registerEmailInputResultProvider = 
    StateNotifierProvider<RegisterEmailInputResultState, String>((ref) => RegisterEmailInputResultState());

  static final registerEmailButtonProvider = 
    StateNotifierProvider<RegisterEmailButtonState, bool>((ref) => RegisterEmailButtonState());

  static final registerEmailButtonPressedProvider = 
    StateNotifierProvider<RegisterEmailButtonPressedState, bool>((ref) => RegisterEmailButtonPressedState());

  static final registerVerificationCodeInputProvider = 
    StateNotifierProvider<RegisterVerificationCodeInputState, String>((ref) => RegisterVerificationCodeInputState());
  
  static final registerVerificationCodeInputResultProvider = 
    StateNotifierProvider<RegisterVerificationCodeInputResultState, String>((ref) => RegisterVerificationCodeInputResultState());

  static final registerVerificationCodeButtonProvider = 
    StateNotifierProvider<RegisterVerificationCodeButtonState, bool>((ref) => RegisterVerificationCodeButtonState());

  static final registerPasswordInputProvider = 
    StateNotifierProvider<RegisterPasswordInputState, String>((ref) => RegisterPasswordInputState());

  static final registerPasswordInputResultProvider = 
    StateNotifierProvider<RegisterPasswordInputResultState, String>((ref) => RegisterPasswordInputResultState());

  static final registerPasswordConfirmInputProvider = 
    StateNotifierProvider<RegisterPasswordConfirmInputState, String>((ref) => RegisterPasswordConfirmInputState());

  static final registerPasswordConfirmInputResultProvider = 
    StateNotifierProvider<RegisterPasswordConfirmInputResultState, String>((ref) => RegisterPasswordConfirmInputResultState());

  /* 회원가입 세 번째 화면 Provider */
  static final registerSurveyCheckProvider = 
    StateNotifierProvider<RegisterSurveyCheckState, String>((ref) => RegisterSurveyCheckState());

  static final registerSurveyEtcInputProvider = 
    StateNotifierProvider<RegisterSurveyEtcInputState, String>((ref) => RegisterSurveyEtcInputState());

  /* 회원가입 실행을 위한 Provider */
  static final requestRegisterProvider = 
    StateNotifierProvider<RequestRegisterState, RequestRegisterModel>((ref) => RequestRegisterState());

  /* ########## 회원가입 관련 메서드 ########## */
  // 회원가입 화면 상 모든 Provider 초기화
  static Future<void> fnInvalidateAll(WidgetRef ref) async {
    await fnInvalidateFirstScreen(ref);
    await fnInvalidateSecondScreen(ref);
    await fnInvalidateThirdScreen(ref);
    
    await fnInvalidate(ref, requestRegisterProvider);
  }
  // 회원가입 첫 번째 화면 Provider 초기화
  static Future<void> fnInvalidateFirstScreen(WidgetRef ref) async {
    await fnInvalidate(ref, registerNicknameInputProvider);
    await fnInvalidate(ref, registerNicknameInpuResultProvider);
    await fnInvalidate(ref, registerNicknameButtonProvider);
    await fnInvalidate(ref, registerSexButtonProvider);
    await fnInvalidate(ref, registerBirthInputProvider);
    await fnInvalidate(ref, registerBirthInputResultProvider);
    await fnInvalidate(ref, registerPrivateCheckProvider);
  }
  // 회원가입 두 번째 화면 Provider 초기화
  static Future<void> fnInvalidateSecondScreen(WidgetRef ref) async {
    await fnInvalidate(ref, registerEmailInputProvider);
    await fnInvalidate(ref, registerEmailInputResultProvider);
    await fnInvalidate(ref, registerEmailButtonProvider);
    await fnInvalidate(ref, registerEmailButtonPressedProvider);
    await fnInvalidate(ref, registerVerificationCodeInputProvider);
    await fnInvalidate(ref, registerVerificationCodeInputResultProvider);
    await fnInvalidate(ref, registerVerificationCodeButtonProvider);
    await fnInvalidate(ref, registerPasswordInputProvider);
    await fnInvalidate(ref, registerPasswordInputResultProvider);
    await fnInvalidate(ref, registerPasswordConfirmInputProvider);
    await fnInvalidate(ref, registerPasswordConfirmInputResultProvider);
  }
  // 회원가입 세 번째 화면 Provider 초기화
  static Future<void> fnInvalidateThirdScreen(WidgetRef ref) async {
    await fnInvalidate(ref, registerSurveyCheckProvider);
    await fnInvalidate(ref, registerSurveyEtcInputProvider);
  }
  // 회원가입 다음 화면으로 이동
  static Future<void> fnGoToNext(WidgetRef ref, BuildContext context, int page) async {
    if(page == 1) {
      if(!fnCheckNickname(ref, context)) return;
      if(!fnCheckSex(ref, context)) return;
      if(!fnCheckBirth(ref, context)) return;
      if(!fnCheckPrivate(ref, context)) return;

      await ref.read(requestRegisterProvider.notifier).setValues(
        nickname: ref.read(registerNicknameInputProvider.notifier).get(),
        sex: ref.read(registerSexButtonProvider.notifier).get(),
        birth: ref.read(registerBirthInputProvider.notifier).get(),
        private_yn: ref.read(registerPrivateCheckProvider.notifier).get(),
      );

      if(!context.mounted) return;
      context.goNamed('register_second_screen');
    }
    if(page == 2) {
      if(!fnCheckEmail(ref, context)) return;
      if(!fnCheckVerificationCode(ref, context)) return;
      if(!fnCheckPassword(ref, context)) return;
      if(!fnCheckPasswordConfirm(ref, context)) return;

      await ref.read(requestRegisterProvider.notifier).setValues(
        email: ref.read(registerEmailInputProvider.notifier).get(),
        password: ref.read(registerPasswordConfirmInputProvider.notifier).get(),
      );

      if(!context.mounted) return;
      context.goNamed('register_third_screen');
    }
    if(page == 3) {
      if(!fnCheckSurvey(ref, context)) return;

      await ref.read(requestRegisterProvider.notifier).setValues(
        survey_summary: ref.read(registerSurveyCheckProvider.notifier).get(),
      );
      // print(ref.read(requestRegisterProvider.notifier).get().toJson());
      if(!context.mounted) return;
      await fnRegisterExec(ref, context);
    }
  }

  /* 1. 회원가입 첫 번째 화면 메서드 */
  static String fnGetNicknameInputCode(String nickname) {
    if(nickname.isEmpty) return ProjectConstant.INPUT_CODE_01;
    if(nickname.length > 8) return ProjectConstant.INPUT_CODE_02;
    
    return ProjectConstant.INPUT_CODE_09;
  }

  static bool fnValidateNicknameInput(String nicknameInputCode) {
    if(nicknameInputCode == ProjectConstant.INPUT_CODE_00 ||
       nicknameInputCode == ProjectConstant.INPUT_CODE_09 ||
       nicknameInputCode == ProjectConstant.INPUT_CODE_10) return true;

    return false;
  }

  static String fnGetNicknameInputCodeStr(String nicknameInputCode) {
    String inputStr = "";

    if(nicknameInputCode == ProjectConstant.INPUT_CODE_01) inputStr = Sentence.NICKNAME_INPUT_EMPTY_ERR;
    if(nicknameInputCode == ProjectConstant.INPUT_CODE_02) inputStr = Sentence.NICKNAME_INPUT_LENGTH_ERR;
    if(nicknameInputCode == ProjectConstant.INPUT_CODE_05) inputStr = Sentence.NICKNAME_INPUT_DUPLICATE_ERR;

    return inputStr;
  }

  static Future<void> fnCheckNicknameExecPrev(WidgetRef ref, BuildContext context) async {
    // 닉네임 검사 결과 코드 가져오기
    String nicknameInputCode = ref.read(registerNicknameInpuResultProvider.notifier).get();
    
    // 닉네임 유효성 검증 - 닉네임 요청 전 입력내용에 오류가 없으면
    if(nicknameInputCode == ProjectConstant.INPUT_CODE_09) {
      // 닉네임 중복확인 API 호출
      await fnCheckNicknameExec(ref, context);
    }
    if(nicknameInputCode == ProjectConstant.INPUT_CODE_00 ||
       nicknameInputCode == ProjectConstant.INPUT_CODE_01) {
      if(!context.mounted) return;
      showAlertDialog(
        context: context,
        middleText: Sentence.NICKNAME_INPUT_EMPTY_ERR
      );
    }
    if(nicknameInputCode == ProjectConstant.INPUT_CODE_02) {
      if(!context.mounted) return;
      showAlertDialog(
        context: context,
        middleText: Sentence.NICKNAME_INPUT_LENGTH_ERR
      );
    }
    // TODO : ProjectConstant.INPUT_CODE_10 일 때

  }
  // 닉네임 중복확인 실행
  static Future<void> fnCheckNicknameExec(WidgetRef ref, BuildContext context) async {
    // 닉네임 가져오기
    String nickname = ref.read(registerNicknameInputProvider.notifier).get();

    final response = await ref.read(registerRepositoryProvider).requestCheckUserNameRepository(
      nickname
    );
    // 닉네임 사용이 가능할 경우 (중복X)
    if(response.response_code == 200) {
      if(!context.mounted) return;
      messageToast(context, Sentence.NICKNAME_INPUT_SUCCESS);
      ref.read(registerNicknameInpuResultProvider.notifier).set(ProjectConstant.INPUT_CODE_10);
      
    } 
    // 닉네임 사용이 불가능할 경우 (중복O) 
    if(response.response_code == 400){
      ref.read(registerNicknameInpuResultProvider.notifier).set(ProjectConstant.INPUT_CODE_05);
    }
  }

  static bool fnCheckNickname(WidgetRef ref, BuildContext context) {
    String nicknameInputCode = ref.read(registerNicknameInpuResultProvider.notifier).get();
    bool result = true;

    if(nicknameInputCode == ProjectConstant.INPUT_CODE_00 ||
       nicknameInputCode == ProjectConstant.INPUT_CODE_01) {
      result = false;
      if(!context.mounted) return result;
      showAlertDialog(
        context: context,
        middleText: Sentence.NICKNAME_INPUT_EMPTY_ERR
      );
    }
    if(nicknameInputCode == ProjectConstant.INPUT_CODE_02) {
      result = false;
      if(!context.mounted) return result;
      showAlertDialog(
        context: context,
        middleText: Sentence.NICKNAME_INPUT_LENGTH_ERR
      );
    }
    if(nicknameInputCode == ProjectConstant.INPUT_CODE_05) {
      result = false;
      if(!context.mounted) return result;
      showAlertDialog(
        context: context,
        middleText: Sentence.NICKNAME_INPUT_DUPLICATE_ERR
      );
    }
    if(nicknameInputCode == ProjectConstant.INPUT_CODE_09 ||
       nicknameInputCode == ProjectConstant.INPUT_CODE_11) {
      result = false;
      if(!context.mounted) return result;
      showAlertDialog(
        context: context,
        middleText: Sentence.NICKNAME_INPUT_TRY_ERR
      );
    }

    return result;
  }

  static bool fnCheckSex(WidgetRef ref, BuildContext context) {
    String sex = ref.read(registerSexButtonProvider.notifier).get();
    bool result = true;

    if(sex == "") {
      result = false;
      if(!context.mounted) return result;
      showAlertDialog(
        context: context,
        middleText: Sentence.SEX_BUTTON_SELECT_ERR
      );
    }
    return result;
  }

  static String fnGetBirthInputCode(String nickname) {
    if(nickname.isEmpty) return ProjectConstant.INPUT_CODE_01;
    if(nickname.length != 10) return ProjectConstant.INPUT_CODE_02; // 1999-99-99
    
    return ProjectConstant.INPUT_CODE_09;
  }

  static bool fnValidateBirthInput(String birthInputCode) {
    if(birthInputCode == ProjectConstant.INPUT_CODE_00 ||
       birthInputCode == ProjectConstant.INPUT_CODE_09 ||
       birthInputCode == ProjectConstant.INPUT_CODE_10) return true;

    return false;
  }

  static String fnGetBirthInputCodeStr(String birthInputCode) {
    String inputStr = "";

    if(birthInputCode == ProjectConstant.INPUT_CODE_01) inputStr = Sentence.BIRTH_INPUT_EMPTY_ERR;
    if(birthInputCode == ProjectConstant.INPUT_CODE_02) inputStr = Sentence.BIRTH_INPUT_LENGTH_ERR;

    return inputStr;
  }

  static bool fnCheckBirth(WidgetRef ref, BuildContext context) {
    String birthInputCode = ref.read(registerBirthInputResultProvider.notifier).get();
    bool result = true;

    if(birthInputCode == ProjectConstant.INPUT_CODE_00 ||
       birthInputCode == ProjectConstant.INPUT_CODE_01) {
      result = false;
      if(!context.mounted) return result;
      showAlertDialog(
        context: context,
        middleText: Sentence.BIRTH_INPUT_EMPTY_ERR
      );
    }
    if(birthInputCode == ProjectConstant.INPUT_CODE_02) {
      result = false;
      if(!context.mounted) return result;
      showAlertDialog(
        context: context,
        middleText: Sentence.BIRTH_INPUT_LENGTH_ERR
      );
    }

    return result;
  }

  static bool fnCheckPrivate(WidgetRef ref, BuildContext context) {
    String private_yn = ref.read(registerPrivateCheckProvider.notifier).get();
    bool result = true;

    if(private_yn == 'N') {
      result = false;
      if(!context.mounted) return result;
      showAlertDialog(
        context: context,
        middleText: Sentence.PRIVATE_CHECK_ERR
      );
    }
    return result;
  }

  /* 2. 회원가입 두 번째 화면 메서드 */
  static String fnGetEmailInputCode(String email) {
    // 이메일 빈값 검사
    if(email.isEmpty) return ProjectConstant.INPUT_CODE_01;
    // 이메일 형식 검사
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if(!regExp.hasMatch(email)) return ProjectConstant.INPUT_CODE_03;
    
    return ProjectConstant.INPUT_CODE_09;
  }

  static bool fnValidateEmailInput(String emailInputCode) {
    if(emailInputCode == ProjectConstant.INPUT_CODE_00 ||
       emailInputCode == ProjectConstant.INPUT_CODE_09 ||
       emailInputCode == ProjectConstant.INPUT_CODE_10) return true;

    return false;
  }

  static String fnGetEmailInputCodeStr(String emailInputCode) {
    String inputStr = "";

    if(emailInputCode == ProjectConstant.INPUT_CODE_01) inputStr = Sentence.EMAIL_INPUT_EMPTY_ERR;
    if(emailInputCode == ProjectConstant.INPUT_CODE_03) inputStr = Sentence.EMAIL_INPUT_FORMAT_ERR;

    return inputStr;
  }

  static Future<void> fnSendVerificationCodeExec(WidgetRef ref, BuildContext context) async {
    String email = ref.read(registerEmailInputProvider.notifier).get();
    String emailInputCode = ref.read(registerEmailInputResultProvider.notifier).get();

    if(emailInputCode == ProjectConstant.INPUT_CODE_09) {
      // TODO : 이메일로 인증코드 발송 로직 추가

      // toast 메시지
      messageToast(context, "메일로 인증번호를 보냈어요");

      ref.read(registerEmailButtonPressedProvider.notifier).set(true);
    }
  }

  static bool fnCheckEmail(WidgetRef ref, BuildContext context) {
    String emailInputCode = ref.read(registerEmailInputResultProvider.notifier).get();
    bool result = true;

    if(emailInputCode == ProjectConstant.INPUT_CODE_00 ||
       emailInputCode == ProjectConstant.INPUT_CODE_01) {
      result = false;
      if(!context.mounted) return result;
      showAlertDialog(
        context: context,
        middleText: Sentence.EMAIL_INPUT_EMPTY_ERR
      );
    }
    if(emailInputCode == ProjectConstant.INPUT_CODE_03) {
      result = false;
      if(!context.mounted) return result;
      showAlertDialog(
        context: context,
        middleText: Sentence.EMAIL_INPUT_FORMAT_ERR
      );
    }
    // 나중에 API 생성 시 주석 해제
    /*if(emailInputCode == ProjectConstant.INPUT_CODE_09) {
      result = false;
      if(!context.mounted) return result;
      showAlertDialog(
        context: context,
        middleText: Sentence.EMAIL_INPUT_TRY_ERR
      );
    }*/

    return result;
  }

  static String fnGetVerificationCodeInputCode(String vCode) {
    // 인증코드 빈값 검사
    if(vCode.isEmpty) return ProjectConstant.INPUT_CODE_01;
    
    return ProjectConstant.INPUT_CODE_09;
  }

  static bool fnValidateVerificationCodeInput(String verificationInputCode) {
    if(verificationInputCode == ProjectConstant.INPUT_CODE_00 ||
       verificationInputCode == ProjectConstant.INPUT_CODE_09 ||
       verificationInputCode == ProjectConstant.INPUT_CODE_10) return true;

    return false;
  }

  static String fnGetVerificationCodeInputCodeStr(String verificationInputCode) {
    String inputStr = "";

    if(verificationInputCode == ProjectConstant.INPUT_CODE_01) inputStr = Sentence.CODE_INPUT_EMPTY_ERR;
    if(verificationInputCode == ProjectConstant.INPUT_CODE_04) inputStr = Sentence.CODE_INPUT_MATCH_ERR;

    return inputStr;
  }

  static Future<void> fnVerifyCodeExec(WidgetRef ref, BuildContext context) async {
    String vCode = ref.read(registerVerificationCodeInputProvider.notifier).get();
    String verificationInputCode = ref.read(registerVerificationCodeInputResultProvider.notifier).get();

    if(verificationInputCode == ProjectConstant.INPUT_CODE_09) {
      // TODO : 인증코드 인증 로직 추가
    }
  }

  static bool fnCheckVerificationCode(WidgetRef ref, BuildContext context) {
    String verificationInputCode = ref.read(registerVerificationCodeInputResultProvider.notifier).get();
    bool result = true;

    if(verificationInputCode == ProjectConstant.INPUT_CODE_00 ||
       verificationInputCode == ProjectConstant.INPUT_CODE_01) {
      result = false;
      if(!context.mounted) return result;
      showAlertDialog(
        context: context,
        middleText: Sentence.CODE_INPUT_EMPTY_ERR
      );
    }

    return result;
  }

  static String fnGetPasswordInputCode(String password) {
    // 비밀번호 빈값 검사
    if(password.isEmpty) return ProjectConstant.INPUT_CODE_01;
    if(password.length < 8 || password.length > 15) return ProjectConstant.INPUT_CODE_02;
    
    return ProjectConstant.INPUT_CODE_09;
  }

  static bool fnValidatePasswordInput(String passwordInputCode) {
    if(passwordInputCode == ProjectConstant.INPUT_CODE_00 ||
       passwordInputCode == ProjectConstant.INPUT_CODE_09 ||
       passwordInputCode == ProjectConstant.INPUT_CODE_10) return true;

    return false;
  }

  static String fnGetPasswordInputCodeStr(String passwordInputCode) {
    String inputStr = "";

    if(passwordInputCode == ProjectConstant.INPUT_CODE_01) inputStr = Sentence.PASSWD_INPUT_EMPTY_ERR;
    if(passwordInputCode == ProjectConstant.INPUT_CODE_02) inputStr = Sentence.PASSWD_INPUT_LENGTH_ERR;

    return inputStr;
  }

  static bool fnCheckPassword(WidgetRef ref, BuildContext context) {
    String passwordInputCode = ref.read(registerPasswordInputResultProvider.notifier).get();
    bool result = true;

    if(passwordInputCode == ProjectConstant.INPUT_CODE_00 ||
       passwordInputCode == ProjectConstant.INPUT_CODE_01) {
      result = false;
      if(!context.mounted) return result;
      showAlertDialog(
        context: context,
        middleText: Sentence.PASSWD_INPUT_EMPTY_ERR
      );
    }
    if(passwordInputCode == ProjectConstant.INPUT_CODE_02) {
      result = false;
      if(!context.mounted) return result;
      showAlertDialog(
        context: context,
        middleText: Sentence.PASSWD_INPUT_LENGTH_ERR
      );
    }

    return result;
  }

  static String fnGetPasswordConfirmInputCode(String password, String passwordConfrim) {
    // 비밀번호 확인 빈값 검사
    if(passwordConfrim.isEmpty) return ProjectConstant.INPUT_CODE_01;
    // 비밀번호, 비밀번호 확인 일치여부 검사
    if(password != passwordConfrim) return ProjectConstant.INPUT_CODE_04;
    
    return ProjectConstant.INPUT_CODE_09;
  }

  static bool fnValidatePasswordConfirmInput(String passwordConrimInputCode) {
    if(passwordConrimInputCode == ProjectConstant.INPUT_CODE_00 ||
       passwordConrimInputCode == ProjectConstant.INPUT_CODE_09 ||
       passwordConrimInputCode == ProjectConstant.INPUT_CODE_10) return true;

    return false;
  }

  static String fnGetPasswordConfirmInputCodeStr(String passwordConrimInputCode) {
    String inputStr = "";

    if(passwordConrimInputCode == ProjectConstant.INPUT_CODE_04) inputStr = Sentence.PASSWD_INPUT_MATCH_ERR;

    return inputStr;
  }

  static bool fnCheckPasswordConfirm(WidgetRef ref, BuildContext context) {
    String passwordConfirmInputCode = ref.read(registerPasswordConfirmInputResultProvider.notifier).get();
    bool result = true;

    if(passwordConfirmInputCode == ProjectConstant.INPUT_CODE_00 ||
       passwordConfirmInputCode == ProjectConstant.INPUT_CODE_01) {
      result = false;
      if(!context.mounted) return result;
      showAlertDialog(
        context: context,
        middleText: Sentence.PASSWD_CONFIRM_EMPTY_TEXT
      );
    }
    if(passwordConfirmInputCode == ProjectConstant.INPUT_CODE_04) {
      result = false;
      if(!context.mounted) return result;
      showAlertDialog(
        context: context,
        middleText: Sentence.PASSWD_INPUT_MATCH_ERR
      );
    }

    return result;
  }

  /* 3. 회원가입 세 번째 화면 메서드 */
  static bool fnCheckSurvey(WidgetRef ref, BuildContext context) {
    String survey_summary = ref.read(registerSurveyCheckProvider.notifier).get();
    String etcInput = ref.read(registerSurveyEtcInputProvider.notifier).get();
    bool result = true;

    if(survey_summary.isEmpty) {
      result = false;
      if(!context.mounted) return result;
      showAlertDialog(
        context: context,
        middleText: Sentence.SURVEY_CHECK_ERR
      );
    }
    if(survey_summary == '4' && etcInput.isEmpty) {
      result = false;
      if(!context.mounted) return result;
      showAlertDialog(
        context: context,
        middleText: Sentence.SURVEY_ETC_INPUT_EMPTY_ERR,
      );
    }
    // 설문조사 값 세팅
    if(survey_summary == '4' && etcInput.isNotEmpty) {
      ref.read(registerSurveyCheckProvider.notifier).set(
        '4,$etcInput'
      );
    }
    return result;
  }

  // 회원가입 실행 
  static Future<void> fnRegisterExec(WidgetRef ref, BuildContext context) async {
    // print(ref.read(requestRegisterProvider.notifier).get().toJson());
    final response = await ref.read(registerRepositoryProvider).requestRegisterRepository(
      ref.read(requestRegisterProvider.notifier).get()
    );

    String resultText = "";

    if(response.response_code == 200 || response.response_code == 201) {
      resultText = Sentence.REGISTER_SUCCESS;
    } else {
      resultText = Sentence.REGISER_FAILED;
    }

    if(!context.mounted) return;

    showConfirmDialog(
      barrierDismissible: false,
      context: context, 
      middleText: resultText,
      onConfirm: () async {
        // provider 초기화

        // 화면 이동
        context.replace('/login_screen');
      }
    );
  }  
}