import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travel_app/domain/api_client/account_api_client.dart';
import 'package:travel_app/domain/api_client/auth_api_client.dart';
import 'package:travel_app/domain/data_providers/session_data_provider.dart';
import 'package:travel_app/domain/model/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _accountApiClient = AccountApiClient();

  UserBloc() : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      emit(UserLoadInProgress());
      try {
        // Здесь можно загрузить пользователя из API или базы данных
        final user = _accountApiClient.getUserInfo();
        emit(UserLoadSuccess(await user));
      } catch (_) {
        emit(UserLoadFailure());
      }
    });
  }
}

