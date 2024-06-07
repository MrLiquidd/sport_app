part of 'favorite_bloc.dart';

abstract class FavoriteListEvent {}

class LoadFavoriteEvents extends FavoriteListEvent {}

class FavoriteListEventLoadNextPage extends FavoriteListEvent{}
class FavoriteListEventLoadReset extends FavoriteListEvent{}
class FavoriteListEventSearchEvent extends FavoriteListEvent{
  final String query;
  FavoriteListEventSearchEvent(this.query);
}
