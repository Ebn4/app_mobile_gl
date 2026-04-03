import 'package:app_mobile/pages/auth/login/loginCtrl.dart';
import 'package:app_mobile/pages/intro/appCtrl.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var ctrl = ref.read(appCtrlProvider.notifier);
      ctrl.getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final routerConfig = ref.watch(routerConfigProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig,
    );
  }
}
