part of 'event_list_bloc.dart';


abstract class EventListState extends Equatable {
  const EventListState();

  @override
  List<Object> get props => [];
}

class EventsInitial extends EventListState {}

class EventsLoading extends EventListState {}

class EventsLoaded extends EventListState {
  final List<Event> events;

  const EventsLoaded(this.events);

  @override
  List<Object> get props => [events];
}

class EventsError extends EventListState {
  final String message;

  const EventsError(this.message);

  @override
  List<Object> get props => [message];
}
