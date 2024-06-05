import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/signup_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Вход',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40.0),
            BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                return TextField(
                  onChanged: (value) {
                    context.read<SignUpBloc>().add(SignUpPhoneChanged(value));
                  },
                  decoration: InputDecoration(
                    labelText: 'Телефон',
                    prefixText: '+7',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20.0),
            BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                return TextField(
                  onChanged: (value) {
                    context.read<SignUpBloc>().add(SignUpPasswordChanged(value));
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Пароль',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  // Действие при нажатии на "Восстановить"
                },
                child: const Text(
                  'Забыли пароль? Восстановить',
                  style: TextStyle(
                    color: Colors.teal,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: state.isSubmitting
                        ? null
                        : () {
                      context.read<SignUpBloc>().add(SignUpSubmitted());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: state.isSubmitting
                        ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                        : const Text(
                      'Войти',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                // Действие при нажатии на "Зарегистрироваться"
              },
              child: const Text(
                'Уже есть аккаунт? Зарегистрироваться',
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}