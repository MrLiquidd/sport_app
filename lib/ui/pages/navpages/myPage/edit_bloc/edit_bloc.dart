import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:travel_app/domain/api_client/account_api_client.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  final _accountApiClient = AccountApiClient();

  EditBloc() : super(EditInitial()){
    on<EditEvent>((event, emit) async {
      if(event is UpdateProfile){
        await loadProfile(event, emit);
      }
    });
  }

  Future<void> loadProfile(
      UpdateProfile event,
      Emitter<EditState> emit,) async{
    emit(ProfileLoading());
    try{
      await _accountApiClient.postUploadInfo(event.profileData);
      emit(ProfileSuccess());
    } catch (e){
      emit(ProfileError(e.toString()));
    }


  }

}
