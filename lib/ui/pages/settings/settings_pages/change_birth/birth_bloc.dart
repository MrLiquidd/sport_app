import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/domain/api_client/settings_api_client.dart';

//BirthEvent
abstract class BirthEvent extends Equatable {
  const BirthEvent();

  @override
  List<Object> get props => [];
}

class ChangeBirth extends BirthEvent {
  final DateTime newBirth;

  const ChangeBirth(this.newBirth);

  @override
  List<Object> get props => [newBirth];
}

// BirthState
abstract class BirthState extends Equatable {
  const BirthState();

  @override
  List<Object> get props => [];
}

class BirthInitial extends BirthState {
  final DateTime currentBirth;

  const BirthInitial(this.currentBirth);

  @override
  List<Object> get props => [currentBirth];
}

class BirthChanging extends BirthState {}

class BirthChanged extends BirthState {}

class BirthFailure extends BirthState{}

// BirthBloc
class BirthBloc extends Bloc<BirthEvent, BirthState> {
  final _settingsApiClient = SettingsApiClient();


  BirthBloc(DateTime currentBirth) : super(BirthInitial(currentBirth)) {
    on<ChangeBirth>((event, emit) async {
      emit(BirthChanging());
      String formattedDate = DateFormat('yyyy-MM-dd').format(event.newBirth);
      final result = await _settingsApiClient.postChangeBirth(formattedDate);
      if (result){
        emit(BirthChanged());
      } else{
        emit(BirthFailure());
      }
    });
  }
}