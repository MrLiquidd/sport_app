import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'event_list_event.dart';
part 'event_list_state.dart';

class EventListBloc extends Bloc<EventListEvent, EventListState> {
  EventListBloc() : super(EventListInitial()) {
    on<EventListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
