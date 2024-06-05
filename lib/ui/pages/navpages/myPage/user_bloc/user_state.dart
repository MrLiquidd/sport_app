part of 'user_bloc.dart';


abstract class UserState {
  const UserState();

  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoadInProgress extends UserState {}

class UserLoadSuccess extends UserState {
  final UserInfoModel user;

  const UserLoadSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UserLoadFailure extends UserState {}
