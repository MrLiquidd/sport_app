part of 'edit_bloc.dart';

abstract class EditEvent {}

class UpdateProfile extends EditEvent{
  final Map<String, dynamic> profileData;

  UpdateProfile({required this.profileData});

}
