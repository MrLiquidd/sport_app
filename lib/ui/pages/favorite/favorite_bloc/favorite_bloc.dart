import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/domain/api_client/event_api_client.dart';
import 'package:travel_app/domain/model/event_model/event_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class EventListContainer{
  final List<Event> events;
  final int currentPage;
  final int totalPage;

  EventListContainer({
    required this.events,
    required this.currentPage,
    required this.totalPage});
}

class FavoriteListBloc extends Bloc<FavoriteListEvent, FavoriteListState> {
  final EventApiClient eventApiClient;

  FavoriteListBloc(this.eventApiClient) : super(EventsInitial()) {
    on<LoadFavoriteEvents>(_onLoadEvents);
    on<UnFavoriteEvent>(_unFavoriteEvent);
  }

  void _onLoadEvents(
      LoadFavoriteEvents event,
      Emitter<FavoriteListState> emit) async {
    emit(EventsLoading());
    try {
      final events = await eventApiClient.getFavoritesEvents();
      emit(EventsLoaded(events));
    } catch (e) {
      emit(EventsError(e.toString()));
    }
  }

  void _unFavoriteEvent(
      UnFavoriteEvent event,
      Emitter<FavoriteListState> emit
      ) async{
    final currentState = state as EventsLoaded;
    try{
      await eventApiClient.deleteFavoriteEvent(event.event_id);
      final updatedEvents = currentState.events
          .where((e) => e.id != event.event_id)
          .toList();
      emit(EventsLoaded(updatedEvents));
    } catch (e){
      emit(EventsError(e.toString()));
    }
  }
}

