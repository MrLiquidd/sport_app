import 'package:bloc/bloc.dart';
import 'package:travel_app/domain/api_client/account_api_client.dart';
import 'package:travel_app/domain/model/user_model/user_model.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final _accountApiClient = AccountApiClient();

  SettingBloc() : super(SettingInitial()) {
    on<LoadSetting>((event, emit) async {
      emit(SettingLoadInProgress());
      try {
        final user = _accountApiClient.getUserSettingsInfo();
        emit(SettingLoadSuccess(await user));
      } catch (_) {
        emit(SettingLoadFailure());
      }
    });
  }
}
