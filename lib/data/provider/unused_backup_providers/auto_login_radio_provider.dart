import 'package:amitamin_frontend/common/common.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AutoLoginRadioState extends StateNotifier<bool> {
  final FlutterSecureStorage storage;

  AutoLoginRadioState({
    required this.storage,
  }) : super(false); 
  
  void init() async {
    final value = await storage.read(key: ProjectConstant.AUTO_LOGIN_YN);

    state = (value == 'Y') ? true : false;
  }

  void toggle() {
    state = !state;

    state ?
      storage.write(key: ProjectConstant.AUTO_LOGIN_YN, value: 'Y') :
      storage.write(key: ProjectConstant.AUTO_LOGIN_YN, value: 'N');
  }
}

final autoLoginRadioProvider = StateNotifierProvider<AutoLoginRadioState, bool>((ref) {
  final storage = ref.watch(secureStorageProvider);

  return AutoLoginRadioState(storage: storage);
});