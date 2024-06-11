// PhoneEvent
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/domain/api_client/settings_api_client.dart';

abstract class PasswordEvent extends Equatable {
  const PasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePassword extends PasswordEvent {
  final String newPassword;
  final String oldPassword;

  const ChangePassword(this.newPassword, this.oldPassword);

  @override
  List<Object> get props => [newPassword, oldPassword];
}

// PhoneState
abstract class PasswordState extends Equatable {
  const PasswordState();

  @override
  List<Object> get props => [];
}

class PasswordInitial extends PasswordState {}

class PasswordChanging extends PasswordState {}

class PasswordChanged extends PasswordState {}

class PasswordFailure extends PasswordState{}

// PhoneBloc
class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final _settingsApiClient = SettingsApiClient();


  PasswordBloc() : super(PasswordInitial()) {
    on<ChangePassword>((event, emit) async {
      emit(PasswordChanging());
      final result = await _settingsApiClient.postChangePassword(event.newPassword, event.oldPassword);
      print(result);
      if (result){
        emit(PasswordChanged());
      } else{
        emit(PasswordFailure());
      }
    });
  }
}
