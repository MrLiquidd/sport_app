import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:travel_app/domain/api_client/auth_api_client.dart';
import 'package:travel_app/domain/data_providers/session_data_provider.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvents, SignUpState> {

  final _authApiClient = AuthApiClient();
  final _sessionDataProvider = SessionDataProvider();

  SignUpBloc(SignUpState initialState) : super(initialState) {
    on<SignUpEvents>((event, emit) async {
      if (event is SignUpCheckStatusEvent) {
        await onSignUpCheckStatusEvent(event, emit);
      } else if (event is SignUpRegisterEvent) {
        await onSignUpLoginEvent(event, emit);
      }
    }, transformer: sequential());
    add(SignUpCheckStatusEvent());
  }

  Future<void> onSignUpCheckStatusEvent(
      SignUpCheckStatusEvent event,
      Emitter<SignUpState> emit,
      ) async {
    emit(SignUpInProgressState());
    final sessionId = await _sessionDataProvider.getRefreshJWTToken();
    final newState = sessionId != null ? SignUpAuthorizedState() : SignUpUnauthorizedState();
    emit(newState);
  }

  Future<void> onSignUpLoginEvent(
      SignUpRegisterEvent event,
      Emitter<SignUpState> emit,
      ) async {
    try {
      emit(SignUpInProgressState());
      await _authApiClient.signup(
          email: event.email,
          password1: event.password1,
          password2: event.password2
      );
      emit(SignUpAuthorizedState());
    } catch (e) {
      emit(SignUpFailureState(e));
    }
  }
}
