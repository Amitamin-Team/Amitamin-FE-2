import 'package:amitamin_frontend/common/common.dart';
import 'package:amitamin_frontend/data/data.dart';
import 'package:amitamin_frontend/data/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginController {

  /* ########## 로그인 관련 Provider ########## */
  static final loginButtonProvider = 
    StateNotifierProvider<LoginButtonState, bool>((ref) => LoginButtonState());

  static final loginAutoCheckProvider = StateNotifierProvider<LoginAutoCheckState, bool>((ref) {
    final storage = ref.watch(secureStorageProvider);

    return LoginAutoCheckState(storage: storage);
  });

  static final loginEmailInputProvider = 
    StateNotifierProvider<LoginEmailInputState, String>((ref) => LoginEmailInputState());

  static final loginPasswordInputProvider = 
    StateNotifierProvider<LoginPasswordInputState, String>((ref) => LoginPasswordInputState());

  /* ########## 로그인 관련 메서드 ########## */
  static Future<void> fnInvalidateAll(WidgetRef ref) async {
    await fnInvalidate(ref, loginButtonProvider);
    await fnInvalidate(ref, loginAutoCheckProvider);
  }

  static Future<void> fnLoginExecPrev(WidgetRef ref, BuildContext context) async {
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

  static Future<void> fnLoginExec(WidgetRef ref, BuildContext context) async {
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
      if(response.access_token.isNotEmpty) {
        if(!context.mounted) return;
        // context.goNamed('home_screen');
        
        // 디버깅 코드
        print(response.access_token);
        print(response.expires_in);
        print(response.refresh_token);
        print(response.token_type);
        print(response.user);
      }
      // 로그인 실패 (응답의 일관성 필요)
      if(response.access_token.isEmpty){
        if(!context.mounted) return;
        showAlertDialog(
          context: context, 
          middleText: "이메일과 비밀번호를 확인해주세요."
        );
        return;
      }
    } catch (e) {
      print(e);
      if(!context.mounted) return;
      showErrorDialog(context: context);
    } 
  }
}