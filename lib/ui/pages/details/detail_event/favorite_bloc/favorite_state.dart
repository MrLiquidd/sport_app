part of 'favorite_bloc.dart';

abstract class FavoriteState {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class EventIsFavoriteState extends FavoriteState {}

class EventUnFavoriteState extends FavoriteState{}

class EventFavoriteLoadingState extends FavoriteState{}

class EventFavoriteErrorState extends FavoriteState{
  final String message;

  const EventFavoriteErrorState(this.message);

  @override
  List<Object> get props => [message];
}