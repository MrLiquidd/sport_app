import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/domain/api_client/api_client_exception.dart';
import 'package:travel_app/domain/blocs/signup_bloc/signup_bloc.dart';

abstract class SignUpViewCubitState{}

class SignUpViewCubitFormFillInProgressState extends SignUpViewCubitState{
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SignUpViewCubitFormFillInProgressState &&
              runtimeType == other.runtimeType;
  @override
  int get hashCode => 0;
}
class SignUpViewCubitErrorState extends SignUpViewCubitState{
  final String errorMessage;

  SignUpViewCubitErrorState(this.errorMessage);

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is SignUpViewCubitErrorState &&
              runtimeType == other.runtimeType &&
              errorMessage == other.errorMessage;

  @override
  int get hashCode => errorMessage.hashCode;
}
class SignUpViewCubitAuthProgressState extends SignUpViewCubitState{
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SignUpViewCubitAuthProgressState &&
              runtimeType == other.runtimeType;
  @override
  int get hashCode => 0;
}
class SignUpViewCubitSuccessAuthState extends SignUpViewCubitState{
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SignUpViewCubitSuccessAuthState &&
              runtimeType == other.runtimeType;
  @override
  int get hashCode => 0;
}


class SignUpViewCubit extends Cubit<SignUpViewCubitState>{
  final SignUpBloc signUpBloc;
  late final StreamSubscription<SignUpState> signUpBlocSubscription;

  SignUpViewCubit(super.initialState, this.signUpBloc){
    _onState(signUpBloc.state);
    signUpBlocSubscription = signUpBloc.stream.listen(_onState);
  }

  bool _isValid(String email, String password1, String password2) =>
      email.isNotEmpty && password1.isNotEmpty && password2.isNotEmpty;

  void auth({required String email, required String password1, required String password2}){
    if (!_isValid(email, password1, password2)) {
      final state = SignUpViewCubitErrorState("Заполните логин и пароль");
      emit(state);
      return;
    }
    signUpBloc.add(SignUpRegisterEvent(
        email: email, password1: password1, password2: password2
    ));
  }


  void _onState(SignUpState state) {
    if (state is SignUpAuthorizedState) {
      signUpBlocSubscription.cancel();
      emit(SignUpViewCubitSuccessAuthState());
    } else if (state is SignUpUnauthorizedState) {
      emit(SignUpViewCubitFormFillInProgressState());
    } else if (state is SignUpFailureState){
      final message = _mapErrorToMessage(state.error);
      emit(SignUpViewCubitErrorState(message));
    } else if (state is SignUpViewCubitAuthProgressState){
      emit(SignUpViewCubitAuthProgressState());
    }else if (state is SignUpCheckStatusInProgressState){
      emit(SignUpViewCubitAuthProgressState());
    }
  }

  String _mapErrorToMessage(Object error){
    if (error is! ApiClientException){
      return 'Неизвестная ошибка, повторите попытку';
    }
    switch (error.type) {
      case ApiClientExceptionType.network:
        return 'Сервер не доступен. Проверте подключение к интернету';
      case ApiClientExceptionType.auth:
        return 'Неправильный логин пароль!';
      case ApiClientExceptionType.sessionExpired:
      case ApiClientExceptionType.other:
        return 'Произошла ошибка. Попробуйте еще раз';
    }
  }

  @override
  Future<void> close() {
    signUpBlocSubscription.cancel();
    return super.close();
  }
}