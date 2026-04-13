import '../../business/models/user/user.dart';

class AppState {
  final User? user;
  final bool isLoading;
  final String? error;
  final bool isInitialized;

  AppState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isInitialized = false,
  });

  AppState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    bool? isInitialized,
    bool clearUser = false,
  }) {
    return AppState(
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}


