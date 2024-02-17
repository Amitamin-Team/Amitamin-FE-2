import 'package:amitamin_frontend/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyScreen extends ConsumerWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      backgroundColor: CustomColor.extraLightGray,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('마이페이지')
            ],
          ),
        ),
      ),
    );
  }
}