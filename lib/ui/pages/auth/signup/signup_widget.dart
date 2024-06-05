import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/resources/resources.dart';
import 'package:travel_app/ui/navigation/main_navigation.dart';
import 'package:travel_app/ui/pages/auth/signup/signup_view_cubit.dart';
import 'package:travel_app/ui/theme/colors.dart';

class _SignUpDataStorage{
  String email = "";
  String password1 = "";
  String password2 = "";
}

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpViewCubit, SignUpViewCubitState>(
      listener: _onSignUpViewCubitStateChange,
      child: Provider(
        create: (_) => _SignUpDataStorage(),
        child: Scaffold(
          body: Container(
            color: AppColors.mainBackground,
            child: SafeArea(
              child: ListView(
                children: const [
                  _HeaderWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSignUpViewCubitStateChange(
      BuildContext context, SignUpViewCubitState state) {
    if (state is SignUpViewCubitSuccessAuthState) {
      MainNavigation.resetNavigation(context);
    }
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 100,
        ),
        SvgPicture.asset(
          AppImages.signup,
          width: 124,
          height: 148,
        ),
        const _FormWidget(),
      ],
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpDataStorage = context.read<_SignUpDataStorage>();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Вход',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const _ErrorMessageWidget(),
          TextField(
            autofocus: false,
            onChanged: (text) => signUpDataStorage.email = text,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
            decoration: InputDecoration(
              hintText: 'E-mail',
              filled: true,
              fillColor: Colors.white,
              enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(color: Colors.white, width: 0),
              ),

              focusedBorder: OutlineInputBorder(
                  borderRadius:BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.white,)
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextField(
            onChanged: (text) => signUpDataStorage.password1 = text,
            decoration: InputDecoration(
              hintText: 'Password',
              filled: true,
              fillColor: Colors.white,
              enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(color: Colors.white, width: 0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius:BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.white, width: 0)
              ),
            ),
            obscureText: true,
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            onChanged: (text) => signUpDataStorage.password2 = text,
            decoration: InputDecoration(
              hintText: 'Repeat Password',
              filled: true,
              fillColor: Colors.white,
              enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(color: Colors.white, width: 0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius:BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.white, width: 0)
              ),
            ),
            obscureText: true,
          ),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(height: 80,),
          const _SignUpButtonWidget(),
        ],
      ),
    );
  }
}

class _SignUpButtonWidget extends StatelessWidget {
  const _SignUpButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SignUpViewCubit>();
    final signUpDataStorage = context.read<_SignUpDataStorage>();
    final canStartAuth = cubit.state is SignUpViewCubitFormFillInProgressState
        || cubit.state is SignUpViewCubitErrorState;
    final onPressed = canStartAuth
        ? () => cubit.auth(
        email: signUpDataStorage.email, password1: signUpDataStorage.password1,
        password2: signUpDataStorage.password2)
        : null;

    final child = cubit.state is SignUpViewCubitAuthProgressState
        ? const SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(strokeWidth: 2),
    )
        : const Text(
      'Зарегистрироваться',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),);
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.textColor1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: child,
      ),
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select((SignUpViewCubit c) {
      final state = c.state;
      return state is SignUpViewCubitErrorState ? state.errorMessage : null;
    });

    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.red,
        ),
      ),
    );
  }
}
