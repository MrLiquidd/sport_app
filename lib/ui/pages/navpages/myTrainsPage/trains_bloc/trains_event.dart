part of 'trains_bloc.dart';

abstract class TrainsListEvent {
  const TrainsListEvent();

  @override
  List<Object> get props => [];
}

class LoadTrainsEvents extends TrainsListEvent {}

class TrainsListEventLoadNextPage extends TrainsListEvent{}
class TrainsListEventLoadReset extends TrainsListEvent{}
class TrainsListEventSearchEvent extends TrainsListEvent{
  final String query;
  TrainsListEventSearchEvent(this.query);
}


class UnRecordEvent extends TrainsListEvent{
  final String event_id;

  const UnRecordEvent(this.event_id);

  @override
  List<Object> get props => [event_id];
}

