part of 'setting_bloc.dart';

abstract class SettingState {
  const SettingState();

  List<Object> get props => [];
}

class SettingInitial extends SettingState {}

class SettingLoadInProgress extends SettingState {}

class SettingLoadSuccess extends SettingState {
  final UserModel user;

  const SettingLoadSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class SettingLoadFailure extends SettingState {}