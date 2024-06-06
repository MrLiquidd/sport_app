import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/domain/api_client/event_api_client.dart';
import 'package:travel_app/domain/blocs/event_bloc/event_list_bloc.dart';
import 'package:travel_app/domain/model/event_model/event_model.dart';
import 'package:travel_app/ui/pages/navpages/myPage/user_bloc/user_bloc.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  final _eventApiClient = EventApiClient();

  EventDetailBloc() : super(EventDetailInitial()) {
    on<FetchEventDetail>((event, emit) async {
      emit(EventDetailLoading());
      try {
        final eventDetail = await _eventApiClient.getDetailEvent(event.id);
        emit(EventDetailLoaded(eventDetail));
      } catch (e) {
        emit(EventDetailError(e.toString()));
      }
    });
  }
}


