import 'package:amitamin_frontend/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

mixin class MyController {
  Future<void> fnLoginOutExec(WidgetRef ref, BuildContext context) async {
    final storage = ref.watch(secureStorageProvider);

    await storage.write(key: ProjectConstant.ACCESS_TOKEN, value: null);
    await storage.write(key: ProjectConstant.REFRESH_TOKEN, value: null);
    await storage.write(key: ProjectConstant.EXPIRES_IN, value: null);
    await storage.write(key: ProjectConstant.LOING_TIME, value: null);
    await storage.write(key: ProjectConstant.AUTO_LOGIN_YN, value: null);

    if(!context.mounted) return;
    context.goNamed('login_screen');
  }
}