part of 'detail_bloc.dart';

@immutable
abstract class DetailState {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailInitial extends DetailState {}

class UserDetailLoading extends DetailState {}

class UserDetailLoaded extends DetailState {
  final UserInfoModel user;

  const UserDetailLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserDetailError extends DetailState {
  final String message;

  const UserDetailError(this.message);

  @override
  List<Object> get props => [message];
}
