part of 'detail_bloc.dart';

abstract class DetailEvent {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class LoadDetails extends DetailEvent{}
