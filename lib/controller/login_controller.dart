import 'package:amitamin_frontend/common/common.dart';
import 'package:amitamin_frontend/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

mixin class LoginController {

  /* ########## 로그인 관련 Provider ########## */
  /* final loginButtonProvider = 
    StateNotifierProvider<LoginButtonState, bool>((ref) => LoginButtonState());

  final loginAutoCheckProvider = StateNotifierProvider<LoginAutoCheckState, bool>((ref) {
    final storage = ref.watch(secureStorageProvider);

    return LoginAutoCheckState(storage: storage);
  });

  final loginEmailInputProvider = 
    StateNotifierProvider<LoginEmailInputState, String>((ref) => LoginEmailInputState());

  final loginPasswordInputProvider = 
    StateNotifierProvider<LoginPasswordInputState, String>((ref) => LoginPasswordInputState()); */

  /* ########## 로그인 관련 메서드 ########## */
  Future<void> fnInvalidateAll(WidgetRef ref) async {
    await fnInvalidate(ref, loginButtonProvider);
    await fnInvalidate(ref, loginAutoCheckProvider);
    await fnInvalidate(ref, loginEmailInputProvider);
    await fnInvalidate(ref, loginPasswordInputProvider);
  }

  Future<void> fnLoginExecPrev(WidgetRef ref, BuildContext context) async {
    String email = ref.read(loginEmailInputProvider.notifier).get();
    String password = ref.read(loginEmailInputProvider.notifier).get();

    if(email.isEmpty) {
      showAlertDialog(
        context: context, 
        middleText: Sentence.EMAIL_INPUT_EMPTY_ERR
      );
      return;
    }
    if(password.isEmpty) {
      showAlertDialog(
        context: context, 
        middleText: Sentence.PASSWD_INPUT_EMPTY_ERR
      );
      return;
    }

    await fnLoginExec(ref, context);
  }

  Future<void> fnLoginExec(WidgetRef ref, BuildContext context) async {
    // 로딩화면 
    showOverlayLoadingDialog(context: context);

    final storage = ref.watch(secureStorageProvider);

    String email = ref.read(loginEmailInputProvider.notifier).get();
    String password = ref.read(loginPasswordInputProvider.notifier).get();
    bool remember_me = ref.read(loginAutoCheckProvider.notifier).get();

    try {
      final response = await ref.read(authRepositoryProvider).requestLoginRepository(
        RequestLoginModel(
          email: email, 
          password: password, 
          remember_me: remember_me
        )
      );
      // 로그인 성공
      if(response.response_code == 200) {
        ResponseLoginModel responseLoginModel = ResponseLoginModel.fromJson(response.data![0]);
        // TODO : 사용자 정보 Provider에 저장
        ResponseLoginUserModel responseLoginUserModel = ResponseLoginUserModel.fromJson(responseLoginModel.user);
        
        // 디버깅 코드
        print(responseLoginModel.access_token);
        print(responseLoginModel.expires_in);
        print(responseLoginModel.refresh_token);
        print(responseLoginModel.token_type);
        print(responseLoginModel.user);

        await storage.write(key: ProjectConstant.ACCESS_TOKEN, value: responseLoginModel.access_token);
        await storage.write(key: ProjectConstant.REFRESH_TOKEN, value: responseLoginModel.refresh_token);
        await storage.write(key: ProjectConstant.EXPIRES_IN, value: responseLoginModel.expires_in.toString());
        await storage.write(key: ProjectConstant.LOING_TIME, value: DateTime.now().toString());

        // Provider 초기화
        fnInvalidateAll(ref);
        // 화면 이동
        if(!context.mounted) return;
        hideOverlayLoadingDialog(context);
        context.goNamed('home_screen');
      }
      // 로그인 실패 (응답의 일관성 필요)
      else if(response.response_code == 401){
        if(!context.mounted) return;
        hideOverlayLoadingDialog(context);
        showAlertDialog(
          context: context, 
          middleText: "이메일 또는 비밀번호를 확인해주세요."
        );
        return;
      } 
      // 기타 실패
      else {
        if(!context.mounted) return;
        hideOverlayLoadingDialog(context);
        showAlertDialog(
          context: context, 
          middleText: "올바르지 않은 요청입니다."
        );
        return;
      }
    } catch (e) {
      // 디버깅 코드
      print("========== Login Exception ==========");
      print(e);

      await storage.write(key: ProjectConstant.ACCESS_TOKEN, value: null);
      await storage.write(key: ProjectConstant.REFRESH_TOKEN, value: null);
      await storage.write(key: ProjectConstant.EXPIRES_IN, value: null);
      await storage.write(key: ProjectConstant.LOING_TIME, value: null);
      await storage.write(key: ProjectConstant.AUTO_LOGIN_YN, value: null);

      if(!context.mounted) return;
      hideOverlayLoadingDialog(context);
      showErrorDialog(context: context);
    } 
  }
}