part of 'user_bloc.dart';


abstract class UserState {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoadInProgress extends UserState {}

class UserLoadSuccess extends UserState {
  final UserInfo user;

  const UserLoadSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UserLoadFailure extends UserState {}
