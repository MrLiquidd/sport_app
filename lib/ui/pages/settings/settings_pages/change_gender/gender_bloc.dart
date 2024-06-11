import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/domain/api_client/settings_api_client.dart';

// GenderEvent
abstract class GenderEvent extends Equatable {
  const GenderEvent();

  @override
  List<Object> get props => [];
}

class ChangeGender extends GenderEvent {
  final String newGender;

  const ChangeGender(this.newGender);

  @override
  List<Object> get props => [newGender];
}

// GenderState
abstract class GenderState extends Equatable {
  const GenderState();

  @override
  List<Object> get props => [];
}

class GenderInitial extends GenderState {
  final String currentGender;

  const GenderInitial(this.currentGender);

  @override
  List<Object> get props => [currentGender];
}

class GenderChanging extends GenderState {}

class GenderChanged extends GenderState {}

class GenderFailure extends GenderState{}

// GenderBloc
class GenderBloc extends Bloc<GenderEvent, GenderState> {
  final _settingsApiClient = SettingsApiClient();


  GenderBloc(String currentPhone) : super(GenderInitial(currentPhone)) {
    on<ChangeGender>((event, emit) async {
      emit(GenderChanging());
      final result = await _settingsApiClient.postChangeGender(event.newGender);
      if (result){
        emit(GenderChanged());
      } else{
        emit(GenderFailure());
      }
    });
  }
}

