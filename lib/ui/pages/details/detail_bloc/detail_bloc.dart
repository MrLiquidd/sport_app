import 'package:bloc/bloc.dart';
import 'package:travel_app/domain/model/event_model/event_model.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc(super.initialState);

  @override
  Stream<String> mapEventToState(String event) async* {
    yield event;
  }

  // DetailBloc() : super(DetailInitial()) {
  //   on<LoadDetails>((event, emit) async {
  //     emit(DetailLoadInProgress());
  //     try {
  //       final _event = Event(id: '', title: 'title', price: 0, about: 'about', minAge: 14, quantity: 12, photoId: '', date: DateTime(2000), isActive: true, createDate: DateTime(2000), archive: false, deleted: false, eventType: 'eventType', full_addresses: 'full_addresses');
  //       emit(DetailLoadSuccess(_event));
  //     } catch (_) {
  //       emit(DetailLoadFailure());
  //     }
  //   });
  // }
}
