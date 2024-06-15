part of 'detail_bloc.dart';

// События
abstract class EventDetailEvent extends Equatable {
  const EventDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchEventDetail extends EventDetailEvent {
  final String event_id;

  const FetchEventDetail(this.event_id);

  @override
  List<Object> get props => [event_id];
}
