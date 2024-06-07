part of 'button_bloc.dart';


abstract class ButtonDetailState extends Equatable {
  const ButtonDetailState();

  @override
  List<Object> get props => [];
}

class ButtonInitial extends ButtonDetailState {}

class EventButtonIsRecordState extends ButtonDetailState {}

class EventButtonUnRecordState extends ButtonDetailState{}

class EventButtonLoadingState extends ButtonDetailState{}

class EventButtonErrorState extends ButtonDetailState{
  final String message;

  const EventButtonErrorState(this.message);

  @override
  List<Object> get props => [message];
}