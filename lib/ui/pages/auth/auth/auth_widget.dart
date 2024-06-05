import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/resources/resources.dart';
import 'package:travel_app/ui/navigation/main_navigation.dart';
import 'package:travel_app/ui/pages/auth/auth_view_cubit.dart';
import 'package:travel_app/ui/theme/colors.dart';

class _AuthDataStorage {
  String login = "";
  String password = "";
}

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthViewCubit, AuthViewCubitState>(
      listener: _onAuthViewCubitStateChange,
      child: Provider(
        create: (_) => _AuthDataStorage(),
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

  void _onAuthViewCubitStateChange(
      BuildContext context, AuthViewCubitState state) {
    if (state is AuthViewCubitSuccessAuthState) {
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
          AppImages.login,
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
    final authDataStorage = context.read<_AuthDataStorage>();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _ErrorMessageWidget(),
          // CustomTextField(
          //   controller: model.loginTextController,
          //   name: "Email",
          //   prefixIcon: null,
          //   inputType: TextInputType.emailAddress,
          //   textCapitalization: TextCapitalization.words,
          // ),
          // CustomTextField(
          //   controller: model.passwordTextController,
          //   name: "Password",
          //   prefixIcon: null,
          //   inputType: TextInputType.text,
          //   textCapitalization: TextCapitalization.words,
          // ),
          TextField(
            onChanged: (text) => authDataStorage.login = text,
          ),
          TextField(
            onChanged: (text) => authDataStorage.password = text,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const _AuthButtonWidget(),
              const SizedBox(width: 30),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(const Color(0xFF01B4E4)),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                child: const Text('Reset password'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthViewCubit>();
    const color = Color(0xFF01B4E4);
    final authDataStorage = context.read<_AuthDataStorage>();
    final canStartAuth = cubit.state is AuthViewCubitFormFillInProgressState
        || cubit.state is AuthViewCubitErrorState;

    final onPressed = canStartAuth
        ? () => cubit.auth(
            login: authDataStorage.login, password: authDataStorage.password)
        : null;

    final child = cubit.state is AuthViewCubitAuthProgressState
        ? const SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Text('Login');
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        textStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
        ),
      ),
      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select((AuthViewCubit c) {
      final state = c.state;
      return state is AuthViewCubitErrorState ? state.errorMessage : null;
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
