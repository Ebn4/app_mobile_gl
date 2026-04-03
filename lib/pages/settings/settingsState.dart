import 'package:app_mobile/business/models/user/user.dart';

class SettingsState {
  final User? user;
  final bool? isLoading;
  final String? error;

  SettingsState({
    this.user,
    this.error,
    this.isLoading,
  });

  SettingsState copyWith({
    final User? user,
    final bool? isLoading,
    final String? error,
  }) {
    return SettingsState(
      user: user ?? this.user, 
      error: error ?? this.error, 
      isLoading: isLoading ?? this.isLoading
    );
  }
}
