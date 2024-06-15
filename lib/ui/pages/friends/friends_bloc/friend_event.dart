part of 'friend_bloc.dart';

abstract class FriendsEvent {}

class FetchFriends extends FriendsEvent {}

class SearchFriends extends FriendsEvent {
  final String query;

  SearchFriends(this.query);
}
