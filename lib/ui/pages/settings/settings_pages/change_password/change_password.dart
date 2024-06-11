import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/theme/colors.dart';

import 'password_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController _oldPasswordController =
  TextEditingController(text: "");
  final TextEditingController _newPasswordController =
  TextEditingController(text: "");

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainBackground,
          title: const Text('Телефон'),
        ),
        body: Container(
          color: AppColors.mainBackground,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _oldPasswordController,
                  decoration: InputDecoration(
                    hintText: 'Старый пароль',
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
                const SizedBox(height: 16.0),
                TextField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    hintText: 'Новый пароль',
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
                const SizedBox(height: 16.0),
                const SizedBox(height: 32.0),
                BlocBuilder<PasswordBloc, PasswordState>(
                  builder: (context, state) {
                    if(state is PasswordInitial){
                      return changeButton(context);
                    }
                    else if (state is PasswordChanging){
                      return const Center(child: CircularProgressIndicator());
                    } else if(state is PasswordFailure){
                      return const Text("Пароль не удалось изменить");
                    }
                    if(state is PasswordChanged){
                      return Column(
                        children: [
                          changeButton(context),
                          const SizedBox(height: 10,),
                          const Text("Пароль успешно изменен",),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget changeButton(BuildContext context){
    return SizedBox(
      width: double.infinity,
      height: 50,
      child:
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.textColor1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () {
          String newPassword = _newPasswordController.text;
          String oldPassword = _oldPasswordController.text;
          context.read<PasswordBloc>().add(ChangePassword(newPassword, oldPassword));
        },
        child: const Text(
          'Изменить телефон',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
