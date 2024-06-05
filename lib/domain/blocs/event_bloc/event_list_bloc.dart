import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/domain/api_client/event_api_client.dart';
import 'package:travel_app/domain/model/event_model/event_model.dart';

part 'event_list_event.dart';
part 'event_list_state.dart';

class EventListContainer{
  final List<Event> events;
  final int currentPage;
  final int totalPage;

  EventListContainer({
    required this.events,
    required this.currentPage,
    required this.totalPage});
}

class EventsBloc extends Bloc<EventListEvent, EventListState> {
  final EventApiClient eventApiClient;

  EventsBloc(this.eventApiClient) : super(EventsInitial()) {
    on<LoadEvents>(_onLoadEvents);
  }

  void _onLoadEvents(LoadEvents event, Emitter<EventListState> emit) async {
    emit(EventsLoading());
    try {
      final events = await eventApiClient.getRecentEvents();
      emit(EventsLoaded(events));
    } catch (e) {
      emit(EventsError(e.toString()));
    }
  }
}
