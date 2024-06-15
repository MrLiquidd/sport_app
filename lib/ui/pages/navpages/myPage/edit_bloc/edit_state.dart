part of 'edit_bloc.dart';


abstract class EditState {}

class EditInitial extends EditState {}

class ProfileLoading extends EditState {}

class ProfileError extends EditState {
  final String error;

  ProfileError(this.error);
}

class ProfileSuccess extends EditState {}