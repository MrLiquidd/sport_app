part of 'friend_bloc.dart';

abstract class FriendsState {}

class FriendsInitial extends FriendsState {}

class FriendsLoading extends FriendsState {}

class FriendsLoaded extends FriendsState {
  final List<UserInfoModel> friends;

  FriendsLoaded(this.friends);
}

class FriendsError extends FriendsState {
  final String errorMessage;

  FriendsError(this.errorMessage);
}