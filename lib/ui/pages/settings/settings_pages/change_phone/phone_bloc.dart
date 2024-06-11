import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/domain/api_client/settings_api_client.dart';

// PhoneEvent
abstract class PhoneEvent extends Equatable {
  const PhoneEvent();

  @override
  List<Object> get props => [];
}

class ChangePhone extends PhoneEvent {
  final String newPhone;

  const ChangePhone(this.newPhone);

  @override
  List<Object> get props => [newPhone];
}

// PhoneState
abstract class PhoneState extends Equatable {
  const PhoneState();

  @override
  List<Object> get props => [];
}

class PhoneInitial extends PhoneState {
  final String currentPhone;

  const PhoneInitial(this.currentPhone);

  @override
  List<Object> get props => [currentPhone];
}

class PhoneChanging extends PhoneState {}

class PhoneChanged extends PhoneState {}

class PhoneFailure extends PhoneState{}

// PhoneBloc
class PhoneBloc extends Bloc<PhoneEvent, PhoneState> {
  final _settingsApiClient = SettingsApiClient();


  PhoneBloc(String currentPhone) : super(PhoneInitial(currentPhone)) {
    on<ChangePhone>((event, emit) async {
      emit(PhoneChanging());
      final result = await _settingsApiClient.postChangePhone(event.newPhone);
      print(result);
      if (result){
        emit(PhoneChanged());
      } else{
        emit(PhoneFailure());
      }
    });
  }
}

