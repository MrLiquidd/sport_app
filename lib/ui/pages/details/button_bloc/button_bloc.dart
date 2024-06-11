import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/domain/api_client/event_api_client.dart';

part 'button_event.dart';
part 'button_state.dart';

class ButtonBloc extends Bloc<ButtonEvent, ButtonDetailState> {
  final _eventApiClient = EventApiClient();

  ButtonBloc() : super(ButtonInitial()) {
    on<ButtonEvent>((event, emit) async {
      if (event is FetchButtonEvent){
        await loadButtonState(event, emit);
      } else if(event is RecordEvent){
        await recordDetailEvent(event, emit);
      } else if(event is UnRecordEvent){
        await unRecordDetailEvent(event, emit);
      }
    });
  }

  Future<void> loadButtonState(
      FetchButtonEvent event,
      Emitter<ButtonDetailState> emit,) async{
    emit(EventButtonLoadingState());
    try{
       bool result = await _eventApiClient.getRecordEvent(event.event_id);
       if (result){
         emit(EventButtonIsRecordState());
       }else{
         emit(EventButtonUnRecordState());
       }
    }catch (e){
      emit(EventButtonErrorState(e.toString()));
    }
  }

  Future<void> recordDetailEvent(
      RecordEvent event,
      Emitter<ButtonDetailState> emit,
      ) async{
    emit(EventButtonLoadingState());
    try{
      final result = await _eventApiClient.postRecordEvent(event.event_id);
      emit(EventButtonIsRecordState());
    } catch (e){
      emit(EventButtonErrorState(e.toString()));
    }
  }

  Future<void> unRecordDetailEvent(
      UnRecordEvent event,
      Emitter<ButtonDetailState> emit,
      ) async{
    emit(EventButtonLoadingState());
    try{
      final result = await _eventApiClient.deleteRecordEvent(event.event_id);
      emit(EventButtonUnRecordState());
    } catch (e){
      emit(EventButtonErrorState(e.toString()));
    }
  }
}
