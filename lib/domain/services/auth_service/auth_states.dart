enum AuthStateStatus {
  authorized,
  notAuthorized,
  inProgress
}

abstract class AuthState {}

class AuthUnauthorizedState extends AuthState {}

class AuthAuthorizedState extends AuthState {}

class AuthFailureState extends AuthState {
  final Object error;

  AuthFailureState(this.error);
}

class AuthInProgressState extends AuthState {}