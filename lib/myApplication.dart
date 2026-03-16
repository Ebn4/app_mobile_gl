import 'package:app_mobile/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApplication extends ConsumerStatefulWidget {
  const MyApplication({super.key});

  @override
  ConsumerState<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends ConsumerState<MyApplication> {
  @override
  Widget build(BuildContext context) {
    final routerConfig = ref.watch(routerConfigProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig,
    );
  }
}
