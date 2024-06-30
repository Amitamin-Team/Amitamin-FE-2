import 'package:amitamin_frontend/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PasswordFindScreen extends ConsumerStatefulWidget {
  const PasswordFindScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PasswordFindScreen> createState() => PasswordFindScreenState();
}

class PasswordFindScreenState extends ConsumerState<PasswordFindScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '비밀번호 찾기',
        leadingDisable: true,
        actionDisable: false,
        actionOnPressed: () => context.pop(),
      ),
      child: WillPopScope(
        onWillPop: () async {
          context.pop();
          return false;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12,),
                  const Text(
                    "이메일을 입력하세요",
                    style: CustomText.body3,
                  ),
                  const SizedBox(height: 12,),
                  OutlinedInput(
                    onChanged: (String email) {
                      
                    },
                    hintText: 'qwerasdf@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                  ),
                  const SizedBox(height: 12,),
                  BlueTextButton(
                    onPressed: () {
                      // TODO : 비밀번호 찾기 로직 추가
                      
                    },
                    text: "임시 비밀번호 발급",
                  ),
                  const SizedBox(height: 12,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}