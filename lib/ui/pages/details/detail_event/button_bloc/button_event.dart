part of 'button_bloc.dart';

abstract class ButtonEvent extends Equatable {
  const ButtonEvent();

  @override
  List<Object> get props => [];
}

class FetchButtonEvent extends ButtonEvent{
  final String event_id;

  const FetchButtonEvent(this.event_id);

  @override
  List<Object> get props => [event_id];
}

class RecordEvent extends ButtonEvent{
  final String event_id;

  const RecordEvent(this.event_id);

  @override
  List<Object> get props => [event_id];

}

class UnRecordEvent extends ButtonEvent{
  final String event_id;

  const UnRecordEvent(this.event_id);

  @override
  List<Object> get props => [event_id];
}
