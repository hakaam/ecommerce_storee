import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

// AuthState for the AuthCubit
class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state
class AuthInitial extends AuthState {}

// Loading state
class AuthLoading extends AuthState {}

// Authenticated state
class AuthAuthenticated extends AuthState {
  final User? user;

  AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

// Error state
class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
