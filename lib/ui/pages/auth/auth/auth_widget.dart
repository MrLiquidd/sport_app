import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/resources/resources.dart';
import 'package:travel_app/ui/navigation/main_navigation.dart';
import 'package:travel_app/ui/pages/auth/auth/auth_view_cubit.dart';
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
          height: 50,
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
            onChanged: (text) => authDataStorage.login = text,
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
            onChanged: (text) => authDataStorage.password = text,
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
          Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Забыли пароль?'),
                  TextButton(
                    onPressed: () {
                      // Handle password recovery
                    },
                    child: const Text(
                      'Восстановить',
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ]
            ),
          ),
          const SizedBox(height: 50,),
          const _AuthButtonWidget(),
          Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Нет аккаунта?'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        MainNavigationRouteNames.signup,
                      );
                    },
                    child: const Text(
                      'Зарегистрироваться',
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ]
            ),
          ),
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
    final authDataStorage = context.read<_AuthDataStorage>();
    final canStartAuth = cubit.state is AuthViewCubitFormFillInProgressState
        || cubit.state is AuthViewCubitErrorState;

    final onPressed = canStartAuth
        ? () => cubit.auth(
            login: authDataStorage.login, password: authDataStorage.password)
        : null;

    final child = cubit.state is AuthViewCubitAuthProgressState
        ? const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Text(
        'Войти',
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
