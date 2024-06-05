part of 'detail_bloc.dart';

abstract class DetailState {
  const DetailState();

  List<Object> get props => [];
}

class DetailInitial extends DetailState {}

class DetailLoadInProgress extends DetailState {}

class DetailLoadSuccess extends DetailState {
  final Event event;

  const DetailLoadSuccess(this.event);

  @override
  List<Object> get props => [event];
}

class DetailLoadFailure extends DetailState {}
