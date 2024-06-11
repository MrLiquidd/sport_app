import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/theme/colors.dart';

import 'phone_bloc.dart';


class ChangePhoneScreen extends StatelessWidget {
  final String currentPhone;
  final TextEditingController _newPhoneController =
  TextEditingController(text: "+7");

  ChangePhoneScreen({super.key, required this.currentPhone});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneBloc(currentPhone),
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
                  decoration: InputDecoration(
                    labelText: 'Текущий телефон',
                    filled: true,
                    fillColor: Colors.white,
                    alignLabelWithHint: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide:
                      const BorderSide(color: Colors.white, width: 0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        )),
                  ),
                  controller: TextEditingController(text: currentPhone),
                  readOnly: true,
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _newPhoneController,
                  decoration: InputDecoration(
                    labelText: 'Новый телефон',
                    hintText: 'Новый телефон',
                    filled: true,
                    alignLabelWithHint: true,
                    fillColor: Colors.white,
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide:
                      const BorderSide(color: Colors.white, width: 0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        )),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16.0),
                const SizedBox(height: 32.0),
                BlocBuilder<PhoneBloc, PhoneState>(
                  builder: (context, state) {
                    if(state is PhoneInitial){
                      return changeButton(context);
                    }
                    else if (state is PhoneChanging){
                      return const Center(child: CircularProgressIndicator());
                    } else if(state is PhoneFailure){
                      return const Text("Телефон не удалось изменить");
                    }
                    if(state is PhoneChanged){
                      return Column(
                        children: [
                          changeButton(context),
                          const SizedBox(height: 10,),
                          const Text("Телефон успешно изменен",),
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
          String newPhone = _newPhoneController.text;
          context.read<PhoneBloc>().add(ChangePhone(newPhone));
        },
        child: const Text(
          'Изменить телефон',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
