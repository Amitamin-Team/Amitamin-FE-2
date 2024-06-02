import 'package:amitamin_frontend/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amitamin_frontend/common/common.dart';
import 'package:go_router/go_router.dart';


class RegisterScreenProvider {
  /* ########## 회원가입 첫 번째 화면에 필요한 Provider ########## */
  static final nicknameButtonProvider = 
    StateNotifierProvider<NicknameButtonState, bool>((ref) => NicknameButtonState());

  static final nicknameInputProvider = 
    StateNotifierProvider<NicknameInputState, String>((ref) => NicknameInputState());

  static final genderButtonProvider = 
    StateNotifierProvider<GenderButtonState, String>((ref) => GenderButtonState());

  static final birthInputProvider = 
    StateNotifierProvider<BirthInputState, String>((ref) => BirthInputState());

  static final privateRadioProvider = 
    StateNotifierProvider<PrivateRadioState, String>((ref) => PrivateRadioState());

  
  /* ########## 회원가입 두 번째 화면에 필요한 Provider ########## */
  static final emailButtonProvider = 
    StateNotifierProvider<EmailButtonState, bool>((ref) => EmailButtonState()); 
  
  static final emailButtonOnPressedProvider = 
    StateNotifierProvider<EmailButtonOnPressedState, bool>((ref) => EmailButtonOnPressedState());

  static final emailInputProvider = 
    StateNotifierProvider<EmailInputState, String>((ref) => EmailInputState());

  static final verificationCodeButtonProvider = 
    StateNotifierProvider<VerificationCodeButtonState, bool>((ref) => VerificationCodeButtonState());

  static final verificationCodeInputProvider = 
    StateNotifierProvider<VerificationCodeInputState, String>((ref) => VerificationCodeInputState());

  static final passwordInputProvider = 
    StateNotifierProvider<PasswordInputState, String>((ref) => PasswordInputState());


  /* ########## 회원가입 세 번째 화면에 필요한 Provider ########## */
  static final surveyRadioProvider = 
    StateNotifierProvider<SurveyRadioState, String>((ref) => SurveyRadioState());


  /* 메서드 */
  static String fnInputValidate(String value, String inputType, {String etcValue = ''}) {
    String inputCode = ProjectConstant.INPUT_CODE_MAP['0009']!['value']!;

    if(value.isEmpty) {
      inputCode = ProjectConstant.INPUT_CODE_MAP['0001']!['value']!;
    } else if(inputType == ProjectConstant.REG_NICKNAME_TYPE && value.length > 8) {
      inputCode = ProjectConstant.INPUT_CODE_MAP['0002']!['value']!;
    } else if(inputType == ProjectConstant.REG_BIRTH_TYPE && value.length != 10) {
      inputCode = ProjectConstant.INPUT_CODE_MAP['0002']!['value']!;
    } else if(inputType == ProjectConstant.REG_EMAIL_TYPE && !fnCheckEmailFormat(value)) {
      inputCode = ProjectConstant.INPUT_CODE_MAP['0003']!['value']!;
    } else if(inputType == ProjectConstant.REG_PASSWD_TYPE && (value.length < 8 || value.length > 15)) {
      inputCode = ProjectConstant.INPUT_CODE_MAP['0002']!['value']!;
    } else if(inputType == ProjectConstant.REG_PASSWD_TYPE && (value != etcValue || etcValue.isEmpty)) {
      inputCode = ProjectConstant.INPUT_CODE_MAP['0004']!['value']!;
    }

    return inputCode;
  }

  static bool fnCheckEmailFormat(String email) {
    bool result = true;

    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    if(!regExp.hasMatch(email)) {
      result = false;
    }

    return result;
  }

  static bool fnConditionConfirm(WidgetRef ref, BuildContext context, 
                                 String value, String state, String conType, {String etcValue = ''}) {
    bool result = false;

    if(conType == ProjectConstant.REG_NICKNAME_TYPE) {
      if(state == ProjectConstant.INPUT_CODE_MAP['0009']!['value']! || 
         state == ProjectConstant.INPUT_CODE_MAP['0010']!['value']!) {
        
        // 닉네임 값 설정
        //ref.read(registerModelProvider.notifier).setNickname(nickname);
        
        result = true;
      } 
      if(state == ProjectConstant.INPUT_CODE_MAP['0001']!['value']! || value.isEmpty) {
        showAlertDialog(context: context, middleText: Sentence.NICKNAME_INPUT_EMPTY_ERR);
      }
      if(state == ProjectConstant.INPUT_CODE_MAP['0002']!['value']!) {
        showAlertDialog(context: context, middleText: Sentence.NICKNAME_INPUT_LENGTH_ERR);
      }
      /*if(state == ProjectConstant.INPUT_CODE_MAP['0009']!['value']!) {
        showAlertDialog(context: context, middleText: Sentence.NICKNAME_INPUT_TRY_ERR);
      }*/
      if(state == ProjectConstant.INPUT_CODE_MAP['0005']!['value']!) {
        showAlertDialog(context: context, middleText: Sentence.NICKNAME_INPUT_DUPLICATE_ERR);
      }
    }
    if(conType == ProjectConstant.REG_SEX_TYPE) {
      if(value != "") {
        // 성별 설정
        // ref.read(registerModelProvider.notifier).setGender(sex);
        result = true;
      } else {
        showAlertDialog(context: context, middleText: Sentence.GENDER_BUTTON_SELECT_ERR);
      }
    }
    if(conType == ProjectConstant.REG_BIRTH_TYPE) {
      if(state == ProjectConstant.INPUT_CODE_MAP['0009']!['value']! || 
         state == ProjectConstant.INPUT_CODE_MAP['0010']!['value']!) {
        // 생년월일 설정
        // ref.read(registerModelProvider.notifier).setBirth(birth);
        result = true;
      }
      if(state == ProjectConstant.INPUT_CODE_MAP['0001']!['value']! || value.isEmpty) {
        showAlertDialog(context: context, middleText: Sentence.BIRTH_INPUT_EMPTY_ERR);
      }
      if(state == ProjectConstant.INPUT_CODE_MAP['0002']!['value']!) {
        showAlertDialog(context: context, middleText: Sentence.BIRTH_INPUT_LENGTH_ERR);
      }
    }
    if(conType == ProjectConstant.REG_PRIVATE_TYPE) {
      if(value == "Y") {
        // 개인정보처리방침 동의 설정
        // ref.read(registerModelProvider.notifier).setPrivateYN("Y");
        result = true;
      } else {
        showAlertDialog(context: context, middleText: Sentence.PRIVATE_RADIO_CHECK_ERR);
      }
    }
    if(conType == ProjectConstant.REG_EMAIL_TYPE) {
      if(state == ProjectConstant.INPUT_CODE_MAP['0009']!['value']! || 
         state == ProjectConstant.INPUT_CODE_MAP['0010']!['value']!) {
        
        result = true;
      }
      if(state == ProjectConstant.INPUT_CODE_MAP['0001']!['value']! || value.isEmpty) {
        showAlertDialog(context: context, middleText: Sentence.EMAIL_INPUT_EMPTY_ERR);
      }
      if(state == ProjectConstant.INPUT_CODE_MAP['0003']!['value']!) {
        showAlertDialog(context: context, middleText: Sentence.EMAIL_INPUT_FORMAT_ERR);
      }
    }
    if(conType == ProjectConstant.REG_CODE_TYPE) {
      if(state == ProjectConstant.INPUT_CODE_MAP['0009']!['value']! || 
         state == ProjectConstant.INPUT_CODE_MAP['0010']!['value']!) {
        // 인증번호 인증 완료 후 이메일 값 세팅
        // ref.read(registerModelProvider.notifier).setEmail(email);
        result = true;
      } 
      if(state == ProjectConstant.INPUT_CODE_MAP['0001']!['value']! || value.isEmpty) {
        showAlertDialog(context: context, middleText: Sentence.CODE_INPUT_EMPTY_ERR);
      }
      /*if(state == ProjectConstant.INPUT_CODE_MAP['0009']!['value']!) {
        showAlertDialog(context: context, middleText: Sentence.CODE_INPUT_TRY_ERR);
      }*/
      if(state == ProjectConstant.INPUT_CODE_MAP['0005']!['value']!) {
        showAlertDialog(context: context, middleText: Sentence.CODE_INPUT_MATCH_ERR);
      }
    }
    if(conType == ProjectConstant.REG_PASSWD_TYPE) {
      if(state == ProjectConstant.INPUT_CODE_MAP['0009']!['value']! || 
         state == ProjectConstant.INPUT_CODE_MAP['0010']!['value']!) {
        // 비밀번호 세팅
        // ref.read(registerModelProvider.notifier).setPassword(password);
        result = true;
      }
      if(state == ProjectConstant.INPUT_CODE_MAP['0001']!['value']! || value.isEmpty) {
        showAlertDialog(context: context, middleText: Sentence.PASSWD_INPUT_EMPTY_ERR);
      }
      if(state == ProjectConstant.INPUT_CODE_MAP['0002']!['value']!) {
        showAlertDialog(context: context, middleText: Sentence.PASSWD_INPUT_LENGTH_ERR);
      }
      if(state == ProjectConstant.INPUT_CODE_MAP['0004']!['value']!) {
        showAlertDialog(context: context, middleText: Sentence.PASSWD_INPUT_MATCH_ERR);
      }
    }
    if(conType == ProjectConstant.REG_SURVEY_TYPE) {
      if(value == "" || value.isEmpty) {
        showAlertDialog(context: context, middleText: Sentence.SURVEY_RADIO_SELECT_ERR);
      }
      if (value == "4" && etcValue.isEmpty) {
        showAlertDialog(context: context, middleText: Sentence.SURVEY_ETC_INPUT_EMPTY_ERR);
      } 
      if(value != "4" ) {
        // 설문조사 결과 값 세팅
        // ref.read(registerModelProvider.notifier).setSurvey(survey_summary);
        
        result = true;
      }
      if(value == "4" && etcValue.isNotEmpty) {
        // 설문조사 결과 값 세팅
        value += ",$etcValue";
        print(value);
        result = true;
      }
    }

    return result;
  }

  static Future<void> fnGoToNext(WidgetRef ref, BuildContext context, int page, 
                       {nicknameInput='',birthInput='',emailInput='',codeInput='',passwdInput='',etcInput=''}) async {
    if(page == 1) {
      bool nicknameResult = fnConditionConfirm(ref, context, nicknameInput, 
                                               ref.read(nicknameInputProvider.notifier).get(), ProjectConstant.REG_NICKNAME_TYPE);
      if(!nicknameResult) return;

      bool sexResult = fnConditionConfirm(ref, context, ref.read(genderButtonProvider.notifier).get(), 
                                          "", ProjectConstant.REG_SEX_TYPE);
      if(!sexResult) return;

      bool birthResult = fnConditionConfirm(ref, context, birthInput, 
                                            ref.read(birthInputProvider.notifier).get(), ProjectConstant.REG_BIRTH_TYPE);
      if(!birthResult) return;

      bool privateResult = fnConditionConfirm(ref, context, ref.read(privateRadioProvider.notifier).get(), 
                                              "", ProjectConstant.REG_PRIVATE_TYPE);
      if(!privateResult) return;

      context.goNamed('register_second_screen');
    }
    if(page == 2) {
      bool emailResult = fnConditionConfirm(ref, context, emailInput,
                                            ref.read(emailInputProvider.notifier).get(), ProjectConstant.REG_EMAIL_TYPE);

      if(!emailResult) return;

      bool codeResult = fnConditionConfirm(ref, context, codeInput,
                                           ref.read(verificationCodeInputProvider.notifier).get(), ProjectConstant.REG_CODE_TYPE);

      if(!codeResult) return;

      bool passwordResult = fnConditionConfirm(ref, context, passwdInput,
                                               ref.read(passwordInputProvider.notifier).get(), ProjectConstant.REG_PASSWD_TYPE);

      if(!passwordResult) return;

      context.goNamed('register_third_screen');
    }
    if(page == 3) {
      bool surveyResult = fnConditionConfirm(ref, context, ref.read(surveyRadioProvider.notifier).get(),
                                            "", ProjectConstant.REG_SURVEY_TYPE, etcValue: etcInput);

      if(!surveyResult) return;

      await fnRegisterExec(ref, context);
    }

  }

  static bool fnGetInputBoolState(String state) {
    bool result = false;

    if(state == ProjectConstant.INPUT_CODE_MAP['0000']!['value']!) result = true;
    if(state == ProjectConstant.INPUT_CODE_MAP['0009']!['value']!) result = true;
    if(state == ProjectConstant.INPUT_CODE_MAP['0010']!['value']!) result = true;

    return result;
  }

  // 회원가입 화면 상 모든 Provider 초기화
  static Future<void> fnInvalidateAll(WidgetRef ref) async {
    await fnInvalidateFirstScreen(ref);
    await fnInvalidateSecondScreen(ref);
    await fnInvalidateThirdScreen(ref);
  }
  // 회원가입 첫 번째 화면 Provider 초기화
  static Future<void> fnInvalidateFirstScreen(WidgetRef ref) async {
    await fnInvalidate(ref, nicknameButtonProvider);
    await fnInvalidate(ref, nicknameInputProvider);
    await fnInvalidate(ref, genderButtonProvider);
    await fnInvalidate(ref, birthInputProvider);
    await fnInvalidate(ref, privateRadioProvider);
  }
  // 회원가입 두 번째 화면 Provider 초기화
  static Future<void> fnInvalidateSecondScreen(WidgetRef ref) async {
    await fnInvalidate(ref, emailButtonProvider);
    await fnInvalidate(ref, emailButtonOnPressedProvider);
    await fnInvalidate(ref, emailInputProvider);
    await fnInvalidate(ref, verificationCodeButtonProvider);
    await fnInvalidate(ref, verificationCodeInputProvider);
    await fnInvalidate(ref, passwordInputProvider);
  }
  // 회원가입 세 번째 화면 Provider 초기화
  static Future<void> fnInvalidateThirdScreen(WidgetRef ref) async {
    await fnInvalidate(ref, surveyRadioProvider);
  }
  // 회원가입 실행
  static Future<void> fnRegisterExec(WidgetRef ref, BuildContext context) async {
    final response = await ref.read(registerRepositoryProvider).requestRegisterRepository(
      requestRegisterModel: ref.read(registerModelProvider.notifier).get()
    );

    if(response.response_code == 200) {
      await fnInvalidateAll(ref);
      if(!context.mounted) return;
      context.replace('/login_screen');
      
    } else {
      if(!context.mounted) return;

      showConfirmDialog(
        context: context, 
        middleText: "회원가입에 실패했습니다.\n로그인 화면으로 이동합니다.", 
        onConfirm: () async {
          await fnInvalidateAll(ref);
          if(!context.mounted) return;
          context.replace('/login_screen');
        }
      );
    }
  }
}

/* ########## 회원가입 첫 번째 화면 ########## */
class NicknameButtonState extends StateNotifier<bool> {
  NicknameButtonState() : super(false);

  void activate(String nickname) {
    if(nickname.isNotEmpty) {
      state = true;
    } else {
      state = false;
    }
  }
}

class NicknameInputState extends StateNotifier<String> {
  NicknameInputState() : super(ProjectConstant.INPUT_CODE_MAP['0000']!['value']!);

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}

class GenderButtonState extends StateNotifier<String> {
  GenderButtonState() : super("");

  void set(String gender) {
    state = gender;
  }

  String get() {
    return state;
  }
}

class BirthInputState extends StateNotifier<String> {
  BirthInputState() : super(ProjectConstant.INPUT_CODE_MAP['0000']!['value']!);

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}

class PrivateRadioState extends StateNotifier<String> {
  PrivateRadioState() : super("N");

  void set(String private) {
    state = private;
  }

  String get() {
    return state;
  }
}

/* ########## 회원가입 두 번째 화면 ########## */
class EmailButtonState extends StateNotifier<bool> {
  EmailButtonState() : super(false);

  void activate(String email) {
    if(email.isNotEmpty) {
      state = true;
    } else {
      state = false;
    }
  }
}

class EmailButtonOnPressedState extends StateNotifier<bool> {
  EmailButtonOnPressedState() : super(false);

  void set(bool value) {
    state = value;
  }

  bool get() {
    return state;
  }

  void setStateLinkedEmail(String state) {
    if(state == ProjectConstant.INPUT_CODE_MAP['0009']!['value']! || 
       state == ProjectConstant.INPUT_CODE_MAP['0010']!['value']!) {
        set(false);
    }
  }
}

class EmailInputState extends StateNotifier<String> {
  EmailInputState() : super(ProjectConstant.INPUT_CODE_MAP['0000']!['value']!);

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}

class VerificationCodeButtonState extends StateNotifier<bool> {
  VerificationCodeButtonState() : super(false);

  void activate(String code) {
    if(code.isNotEmpty) {
      state = true;
    } else {
      state = false;
    }
  }
}

class VerificationCodeInputState extends StateNotifier<String> {
  VerificationCodeInputState() : super(ProjectConstant.INPUT_CODE_MAP['0000']!['value']!);

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}

class PasswordInputState extends StateNotifier<String> {
  PasswordInputState() : super(ProjectConstant.INPUT_CODE_MAP['0000']!['value']!);

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}

/* ########## 회원가입 세 번째 화면 ########## */
class SurveyRadioState extends StateNotifier<String> {
  SurveyRadioState() : super("");

  void set(String value) {
    state = value;
  }

  String get() {
    return state;
  }
}