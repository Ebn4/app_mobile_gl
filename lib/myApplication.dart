import 'package:app_mobile/pages/auth/login/loginCtrl.dart';
import 'package:app_mobile/pages/intro/appCtrl.dart';
import 'package:app_mobile/pages/intro/appState.dart';
import 'package:app_mobile/pages/widgets/mainLayout.dart';
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
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var ctrl = ref.read(appCtrlProvider.notifier);
      ctrl.getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final routerConfig = ref.watch(routerConfigProvider);

    return Consumer(
      builder: (context, ref, child) {
        // Écouter les changements d'état pour gérer la déconnexion
        ref.listen<AppState>(appCtrlProvider, (previous, next) {
          // Si l'utilisateur était connecté et ne l'est plus, rediriger
          if (previous?.user != null && next.user == null) {
            // Réinitialiser l'index de navigation à 0 (home)
            ref.read(bottomNavIndexProvider.notifier).state = 0;
            // Utiliser replace pour remplacer l'historique de navigation
            routerConfig.replace('/public/login');
          }
        });

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: routerConfig,
        );
      },
    );
  }
}
