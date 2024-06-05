part of 'event_list_bloc.dart';

abstract class EventListEvent {}

class LoadEvents extends EventListEvent {}

class EventListEventLoadNextPage extends EventListEvent{}
class EventListEventLoadReset extends EventListEvent{}
class EventListEventSearchEvent extends EventListEvent{
  final String query;
  EventListEventSearchEvent(this.query);

}


