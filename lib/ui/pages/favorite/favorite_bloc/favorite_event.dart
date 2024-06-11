part of 'favorite_bloc.dart';

abstract class FavoriteListEvent {
  const FavoriteListEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoriteEvents extends FavoriteListEvent {}

class FavoriteListEventLoadNextPage extends FavoriteListEvent{}
class FavoriteListEventLoadReset extends FavoriteListEvent{}
class FavoriteListEventSearchEvent extends FavoriteListEvent{
  final String query;
  FavoriteListEventSearchEvent(this.query);
}

class UnFavoriteEvent extends FavoriteListEvent{
  final String event_id;

  const UnFavoriteEvent(this.event_id);

  @override
  List<Object> get props => [event_id];
}
