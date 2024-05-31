import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> fnInvalidate(WidgetRef ref, ProviderOrFamily provider) async {
  ref.invalidate(provider);
}