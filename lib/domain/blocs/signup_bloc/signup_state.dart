part of 'signup_bloc.dart';

abstract class SignUpState {}

class SignUpUnauthorizedState extends SignUpState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SignUpUnauthorizedState;

  @override
  int get hashCode => 0;
}

class SignUpAuthorizedState extends SignUpState {

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SignUpAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class SignUpFailureState extends SignUpState {
  final Object error;

  SignUpFailureState(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SignUpFailureState &&
              runtimeType == other.runtimeType &&
              error == other.error;

  @override
  int get hashCode => error.hashCode;
}

class SignUpInProgressState extends SignUpState {

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SignUpInProgressState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class SignUpCheckStatusInProgressState extends SignUpState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SignUpCheckStatusInProgressState &&
              runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}