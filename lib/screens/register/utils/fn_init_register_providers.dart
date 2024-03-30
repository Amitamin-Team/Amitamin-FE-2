import 'package:amitamin_frontend/data/provider/provider.dart';
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
}

void fnInitRegisterFirstScreenProviders(WidgetRef ref) {
    ref.invalidate(nicknameButtonProvider);
    ref.invalidate(nicknameInputProvider);
    ref.invalidate(genderButtonProvider);
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

