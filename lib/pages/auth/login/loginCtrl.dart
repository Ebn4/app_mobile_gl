import 'package:app_mobile/business/models/user/authentication.dart';
import 'package:app_mobile/business/services/user/userLocalService.dart';
import 'package:app_mobile/business/services/user/userNetworkService.dart';
import 'package:app_mobile/main.dart';
import 'package:app_mobile/pages/auth/login/loginState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class Loginctrl extends StateNotifier<LoginState> {
  var userNetworkService = getIt.get<UserNetworkService>();
  var userLocalService = getIt.get<UserLocalService>();
  
  Loginctrl() : super(LoginState()) {
    _loadUserFromStorage();
  }

  /// Charger l'utilisateur depuis le stockage local au démarrage
  Future<void> _loadUserFromStorage() async {
    try {
      final user = await userLocalService.getUser();
      if (user != null) {
        state = state.copyWith(user: user, isLoading: false);
      }
    } catch (e) {
      // Ne pas faire d'erreur si aucun utilisateur n'est trouvé
      print('Erreur chargement utilisateur: $e');
    }
  }

  Future<void> login(Authentication data) async {
    try {
      // Réinitialiser l'erreur précédente
      state = state.copyWith(isLoading: true, error: null);
      print('Tentative de connexion avec: ${data.email}');
      
      var user = await userNetworkService.login(data);
      print('Connexion réussie: ${user.email}');
      
      state = state.copyWith(user: user, isLoading: false, error: null);
      await userLocalService.saveUser(user);
    } catch (e) {
      print('Erreur de connexion: $e');
      state = state.copyWith(
        isLoading: false, 
        error: e.toString()
      );
    }
  }

  Future<void> recupererUserLocal() async {
    final user = await userLocalService.getUser();
    state = state.copyWith(user: user);
  }

  Future<void> logout() async {
    await userLocalService.clearUser();
    state = state.copyWith(user: null, error: null, isLoading: false);
  }
}

final loginCtrlProvider = StateNotifierProvider<Loginctrl, LoginState>((ref) {
  return Loginctrl();
});