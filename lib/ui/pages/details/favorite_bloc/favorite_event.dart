part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}


class FetchFavoriteEvent extends FavoriteEvent{
  final String event_id;

  const FetchFavoriteEvent(this.event_id);

  @override
  List<Object> get props => [event_id];
}

class AddFavoriteEvent extends FavoriteEvent{
  final String event_id;

  const AddFavoriteEvent(this.event_id);

  @override
  List<Object> get props => [event_id];

}

class UnFavoriteEvent extends FavoriteEvent{
  final String event_id;

  const UnFavoriteEvent(this.event_id);

  @override
  List<Object> get props => [event_id];
}

