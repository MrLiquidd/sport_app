part of 'search_bloc.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {
}

class SearchLoading extends SearchState{}

class SearchLoaded extends SearchState{
  final List<Event> events;

  SearchLoaded(this.events);
}

class SearchError extends SearchState{
  final String errorMessage;

  SearchError(this.errorMessage);
}