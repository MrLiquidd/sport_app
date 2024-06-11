part of 'favorite_bloc.dart';


abstract class FavoriteListState extends Equatable {
  const FavoriteListState();

  @override
  List<Object> get props => [];
}

class EventsInitial extends FavoriteListState {}

class EventsLoading extends FavoriteListState {}

class EventsLoaded extends FavoriteListState {
  final List<Event> events;

  const EventsLoaded(this.events);

  @override
  List<Object> get props => [events];
}

class EventsError extends FavoriteListState {
  final String message;

  const EventsError(this.message);

  @override
  List<Object> get props => [message];
}
