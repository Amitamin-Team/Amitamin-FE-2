import 'package:amitamin_frontend/common/common.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginAutoCheckState extends StateNotifier<bool> {
  final FlutterSecureStorage storage;

  LoginAutoCheckState({
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

  void set(bool value) {
    state = value;
  }

  bool get() {
    return state;
  }
}

final loginAutoCheckProvider = StateNotifierProvider<LoginAutoCheckState, bool>((ref) {
    final storage = ref.watch(secureStorageProvider);

    return LoginAutoCheckState(storage: storage);
  });