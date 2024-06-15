part of 'search_bloc.dart';


abstract class SearchEvent {}

class FetchAllEvents extends SearchEvent{}

class FetchTrainsEvents extends SearchEvent{}

class FetchGamesEvents extends SearchEvent{}

class SearchQueryEvents extends SearchEvent{
  final String query;

  SearchQueryEvents(this.query);
}
