import 'package:amitamin_frontend/data/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTabView extends ConsumerWidget {
  const HomeTabView({
    Key? key,
    required this.children
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentHomeTabIndex = ref.watch(homeTabProvider);

    return children[currentHomeTabIndex];
  }
}