part of 'detail_bloc.dart';

// События
abstract class EventDetailEvent extends Equatable {
  const EventDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchEventDetail extends EventDetailEvent {
  final String id;

  const FetchEventDetail(this.id);

  @override
  List<Object> get props => [id];
}
