import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:travel_app/domain/api_client/account_api_client.dart';
import 'package:travel_app/domain/api_client/auth_api_client.dart';
import 'package:travel_app/domain/data_providers/session_data_provider.dart';
import 'auth_states.dart';
import 'auth_events.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  final _authApiClient = AuthApiClient();
  final _accountApiClient = AccountApiClient();
  final _sessionDataProvider = SessionDataProvider();

  AuthBloc(AuthState initialState) : super(initialState) {
    on<AuthEvents>((event, emit) async {
      if (event is AuthCheckStatusEvent) {
        onAuthCheckStatusEvent(event, emit);
      }else if (event is AuthLoginEvent){
        onAuthLoginEvent(event, emit);
      }else if (event is AuthLogoutEvent){
        onAuthLogoutEvent(event, emit);
      }
    }, transformer: sequential());

    add(AuthCheckStatusEvent());
  }

  void onAuthCheckStatusEvent
      (AuthCheckStatusEvent event, Emitter<AuthState> emit,) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final newState =
    sessionId != null ? AuthAuthorizedState() : AuthUnauthorizedState();
    emit(newState);
  }
  void onAuthLoginEvent
      (AuthLoginEvent event, Emitter<AuthState> emit,) async {
    try {
      final sessionId = await _authApiClient.auth(
        username: event.login,
        password: event.password,
      );

      //final accountId = await _accountApiClient.getAccountInfo(sessionId);
      await _sessionDataProvider.setSessionId(sessionId);
      //await _sessionDataProvider.setAccountId(accountId);
      emit(AuthAuthorizedState());
    } catch (e) {
      emit(AuthFailureState(e));
    }
  }
  void onAuthLogoutEvent
      (AuthLogoutEvent event, Emitter<AuthState> emit,) async {
    try {
      await _sessionDataProvider.deleteSessionId();
      //await _sessionDataProvider.deleteAccountId();
    } catch (e) {
      emit(AuthFailureState(e));
    }
  }
}
