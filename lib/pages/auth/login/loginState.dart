import 'package:app_mobile/business/models/user/user.dart';

class LoginState {
  final bool isLoading;
  final String error;
  final User user;

  LoginState({required this.isLoading, required this.error, required this.user});
  
  LoginState copyWith({bool? isLoading, String? error, User? user}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }
}