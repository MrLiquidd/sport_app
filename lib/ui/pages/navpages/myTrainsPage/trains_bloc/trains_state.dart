part of 'trains_bloc.dart';

@immutable
abstract class TrainsListState {
  const TrainsListState();

  @override
  List<Object> get props => [];
}

class TrainsInitial extends TrainsListState {}

class EventsLoading extends TrainsListState {}

class EventsLoaded extends TrainsListState {
  final List<Event> events;

  const EventsLoaded(this.events);

  @override
  List<Object> get props => [events];
}

class EventsError extends TrainsListState {
  final String message;

  const EventsError(this.message);

  @override
  List<Object> get props => [message];
}