import 'package:bloc/bloc.dart';
import 'package:travel_app/domain/api_client/account_api_client.dart';
import 'package:travel_app/domain/model/user_info_model/user_info_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _accountApiClient = AccountApiClient();

  UserBloc() : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      emit(UserLoadInProgress());
      try {
        final user = _accountApiClient.getUserInfo();
        emit(UserLoadSuccess(await user));
      } catch (_) {
        emit(UserLoadFailure());
      }
    });
  }
}

