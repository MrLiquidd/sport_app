import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:travel_app/domain/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/domain/blocs/auth_bloc/auth_events.dart';
import 'package:travel_app/domain/blocs/auth_bloc/auth_states.dart';

enum LoaderViewCubitState{ unknown, authorized, notAuthorized }

class LoaderViewCubit extends Cubit<LoaderViewCubitState>{
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription;

  LoaderViewCubit(super.initialState, this.authBloc){
    authBloc.add(AuthCheckStatusEvent());
    onState(authBloc.state);
    authBloc.stream.listen(onState);
  }


  void onState(AuthState state) {
    if (state is AuthAuthorizedState) {
      emit(LoaderViewCubitState.authorized);
    } else if (state is AuthUnauthorizedState) {
      emit(LoaderViewCubitState.notAuthorized);
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}
