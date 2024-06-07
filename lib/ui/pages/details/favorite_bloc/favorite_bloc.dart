import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travel_app/domain/api_client/event_api_client.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';


class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final _eventApiClient = EventApiClient();

  FavoriteBloc() : super(FavoriteInitial()) {
    on<FavoriteEvent>((event, emit) async {
      if (event is FetchFavoriteEvent){
        await loadButtonState(event, emit);
      } else if(event is AddFavoriteEvent){
        await recordDetailEvent(event, emit);
      } else if(event is UnFavoriteEvent){
        await unRecordDetailEvent(event, emit);
      }
    });
  }

  Future<void> loadButtonState(
      FetchFavoriteEvent event,
      Emitter<FavoriteState> emit,) async{
    emit(EventFavoriteLoadingState());
    try{
      bool result = await _eventApiClient.getFavoriteEvent(event.event_id);
      if (result){
        emit(EventIsFavoriteState());
      }else{
        emit(EventUnFavoriteState());
      }
    }catch (e){
      emit(EventFavoriteErrorState(e.toString()));
    }
  }

  Future<void> recordDetailEvent(
      AddFavoriteEvent event,
      Emitter<FavoriteState> emit,
      ) async{
    emit(EventFavoriteLoadingState());
    try{
      final result = await _eventApiClient.postFavoriteEvent(event.event_id);
      emit(EventIsFavoriteState());
    } catch (e){
      emit(EventFavoriteErrorState(e.toString()));
    }
  }

  Future<void> unRecordDetailEvent(
      UnFavoriteEvent event,
      Emitter<FavoriteState> emit,
      ) async{
    emit(EventFavoriteLoadingState());
    try{
      final result = await _eventApiClient.deleteFavoriteEvent(event.event_id);
      emit(EventUnFavoriteState());
    } catch (e){
      emit(EventFavoriteErrorState(e.toString()));
    }
  }
}
