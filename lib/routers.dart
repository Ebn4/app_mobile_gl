import 'package:app_mobile/pages/auth/login/loginPage.dart';
import 'package:app_mobile/pages/auth/login/loginCtrl.dart';
import 'package:app_mobile/pages/auth/register/registerPage.dart';
import 'package:app_mobile/pages/changePassword/changePasswordPage.dart';
import 'package:app_mobile/pages/citizen/citizenInfoPage.dart';
import 'package:app_mobile/pages/history/historyPage.dart';
import 'package:app_mobile/pages/intro/appCtrl.dart';
import 'package:app_mobile/pages/profile/profileEditPage.dart';
import 'package:app_mobile/pages/scanner/scannerPage.dart';
import 'package:app_mobile/pages/settings/settingsPage.dart';
import 'package:app_mobile/pages/widgets/mainLayout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'pages/404/not_found_page.dart';
import 'pages/intro/introPage.dart';
import 'utils/navigationUtils.dart';
import './main.dart';
import 'pages/home/homePage.dart';

final routerConfigProvider = Provider<GoRouter>((ref) {
  final navigatorKey = getIt<NavigationUtils>().navigatorKey;
  /*
   routes restreintes
  */
  final authRoutes = [
    GoRoute(
      path: "/app/home",
      name: 'home_page',
      builder: (ctx, state) {
        return Consumer(
          builder: (context, ref, _) {
            return const MainLayout();
          },
        );
      },
    ),
  ];

  /*
   routes publics
  */
  final noAuthRoutes = [
    GoRoute(
      path: "/public/intro",
      name: 'intro_page',
      builder: (ctx, state) {
        return IntroPage();
      },
    ),

    GoRoute(
      path: "/public/login",
      name: 'login_page',
      builder: (ctx, state) {
        return LoginPage();
      },
    ),

    GoRoute(
      path: "/public/register",
      name: 'register_page',
      builder: (ctx, state) {
        return RegisterPage();
      },
    ),

    GoRoute(
      path: "/app/scanner",
      name: 'scanner_page',
      builder: (ctx, state) {
        return ScannerPage();
      },
    ),

    GoRoute(
      path: "/app/settings",
      name: 'settings_page',
      builder: (ctx, state) {
        return SettingsPage();
      },
    ),

    GoRoute(
      path: "/app/history",
      name: 'history_page',
      builder: (ctx, state) {
        return HistoryPage();
      },
    ),

    GoRoute(
      path: "/app/profile/edit",
      name: 'profile_edit_page',
      builder: (ctx, state) {
        return ProfileEditPage();
      },
    ),

    GoRoute(
      path: "/app/change-password",
      name: 'change_password_page',
      builder: (ctx, state) {
        return ChangePasswordPage();
      },
    ),
  ];

  /*
CONFIGURATION  DES ROUTES
*/
  return GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: "/public/intro",
    redirect: (context, state) async {
      final appState = ref.read(appCtrlProvider);

      // Toujours laisser IntroPage s'afficher
      if (state.matchedLocation == "/public/intro") {
        return null;
      }

      final isAuthInProgress = appState.user == null && appState.error == null;

      if (isAuthInProgress) {
        await ref.read(appCtrlProvider.notifier).getUser();
      }

      final updatedState = ref.read(appCtrlProvider);
      final user = updatedState.user;

      // Utilisateur connecté
      if (user != null) {
        if (state.matchedLocation.startsWith("/public/")) {
          return "/app/home";
        }
        return null;
      }

      // Utilisateur non connecté
      if (state.matchedLocation.startsWith("/app/")) {
        return "/public/login";
      }

      return null;
    },
    routes: [...noAuthRoutes, ...authRoutes],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
});
