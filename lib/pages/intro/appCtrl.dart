import 'package:app_mobile/business/services/user/userLocalService.dart';
import 'package:app_mobile/main.dart';
import 'package:app_mobile/pages/intro/appState.dart';
import 'package:flutter_riverpod/legacy.dart';

class AppCtrl extends StateNotifier<AppState> {
  var userLocalService = getIt<UserLocalService>();

  AppCtrl() : super(AppState());

  Future<void> getUser() async {
    try {
      var user = await userLocalService.getUser();
      state = state.copyWith(user: user);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> clearUser() async {
    try {
      await userLocalService.clearUser();
      state = AppState(user: null, isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

final appCtrlProvider = StateNotifierProvider<AppCtrl, AppState>((ref) {
  ref.keepAlive();
  return AppCtrl();   
});
