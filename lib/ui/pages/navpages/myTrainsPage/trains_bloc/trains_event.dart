part of 'trains_bloc.dart';

abstract class TrainsListEvent {}

class LoadTrainsEvents extends TrainsListEvent {}

class TrainsListEventLoadNextPage extends TrainsListEvent{}
class TrainsListEventLoadReset extends TrainsListEvent{}
class TrainsListEventSearchEvent extends TrainsListEvent{
  final String query;
  TrainsListEventSearchEvent(this.query);
}

