import 'package:app_mobile/business/services/user/userLocalService.dart';
import 'package:app_mobile/main.dart';
import 'package:app_mobile/pages/auth/login/loginCtrl.dart';
import 'package:app_mobile/pages/intro/appCtrl.dart';
import 'package:app_mobile/pages/settings/settingsState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class SettingsCtrl extends StateNotifier<SettingsState> {
  var userLocalService = getIt.get<UserLocalService>();
  final Ref ref;
  SettingsCtrl({required this.ref}) : super(SettingsState());

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    try {
      await userLocalService.clearUser();
      await ref.read(loginCtrlProvider.notifier).logout();
      await ref.read(appCtrlProvider.notifier).clearUser();
      state = SettingsState(); // Réinitialisation COMPLÈTE de l'état
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Erreur lors de la déconnexion: ${e.toString()}",
      );
    }
  }
}

final settingsCtrlProvider =
    StateNotifierProvider<SettingsCtrl, SettingsState>(
      (ref) => SettingsCtrl(ref: ref)
    );
