import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travel_app/domain/api_client/event_api_client.dart';
import 'package:travel_app/domain/model/event_model/event_model.dart';

part 'trains_event.dart';
part 'trains_state.dart';

class EventListContainer{
  final List<Event> events;
  final int currentPage;
  final int totalPage;

  EventListContainer({
    required this.events,
    required this.currentPage,
    required this.totalPage});
}


class TrainsListBloc extends Bloc<TrainsListEvent, TrainsListState> {
  final EventApiClient eventApiClient;

  TrainsListBloc(this.eventApiClient) : super(TrainsInitial()) {
    on<LoadTrainsEvents>(_onLoadEvents);
    on<UnRecordEvent>(_unFavoriteEvent);
  }

  void _onLoadEvents(
      LoadTrainsEvents event,
      Emitter<TrainsListState> emit) async {
    emit(EventsLoading());
    try {
      final events = await eventApiClient.getRecordsEvents();
      emit(EventsLoaded(events));
    } catch (e) {
      emit(EventsError(e.toString()));
    }
  }

  void _unFavoriteEvent(
      UnRecordEvent event,
      Emitter<TrainsListState> emit
      ) async{
    try{
      await eventApiClient.deleteRecordEvent(event.event_id);
    } catch (e){
      emit(EventsError(e.toString()));
    }
  }
}


