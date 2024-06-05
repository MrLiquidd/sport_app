part of 'signup_bloc.dart';

abstract class SignUpEvents {}

class SignUpCheckStatusEvent extends SignUpEvents {}

class SignUpRegisterEvent extends SignUpEvents{
  final String email;
  final String password1;
  final String password2;

  SignUpRegisterEvent({
    required this.email,
    required this.password1,
    required this.password2,
});
}
