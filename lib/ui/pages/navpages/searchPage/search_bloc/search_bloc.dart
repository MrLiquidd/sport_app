import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:travel_app/domain/api_client/event_api_client.dart';
import 'package:travel_app/domain/model/event_model/event_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final eventApiClient =  EventApiClient();

  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async{
      if (event is FetchAllEvents){
        await _onFetchAllEvents(event, emit);
      } else if (event is FetchGamesEvents){
        await _onFetchGamesEvents(event, emit);
      } else if (event is FetchTrainsEvents){
        await _onFetchTrainsEvents(event, emit);
      } else if (event is SearchQueryEvents){
        await _onSearchEvents(event, emit);
      }
    });
  }

  Future<void> _onFetchAllEvents(
      FetchAllEvents event,
      Emitter<SearchState> emit
      ) async{
    emit(SearchLoading());
    try{
      final events = await eventApiClient.getAllEvents();
      emit(SearchLoaded(events));
    } catch (e){
      emit(SearchError(e.toString()));
    }
  }

  Future<void> _onFetchGamesEvents(
      FetchGamesEvents event,
      Emitter<SearchState> emit
      ) async{
    emit(SearchLoading());
    try{
      final events = await eventApiClient.getGames();
      emit(SearchLoaded(events));
    } catch (e){
      emit(SearchError(e.toString()));
    }
  }

  Future<void> _onFetchTrainsEvents(
      FetchTrainsEvents event,
      Emitter<SearchState> emit
      ) async{
    emit(SearchLoading());
    try{
      final events = await eventApiClient.getTrainings();
      emit(SearchLoaded(events));
    } catch (e){
      emit(SearchError(e.toString()));
    }
  }

  Future<void> _onSearchEvents(
      SearchQueryEvents event,
      Emitter<SearchState> emit
      ) async{
    emit(SearchLoading());
    try{
      final events = await eventApiClient.getSearchEvents(event.query);
      print(events);
      emit(SearchLoaded(events));
    } catch (e){
      emit(SearchError(e.toString()));
    }
  }
}
