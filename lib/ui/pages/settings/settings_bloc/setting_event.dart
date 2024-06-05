part of 'setting_bloc.dart';

abstract class SettingEvent {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class LoadSetting extends SettingEvent {}