import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/theme/colors.dart';

import 'gender_bloc.dart';

class ChangeGenderScreen extends StatefulWidget {
  final String currentGender;

  const ChangeGenderScreen({super.key, required this.currentGender});

  @override
  _ChangeGenderScreen createState() =>
      _ChangeGenderScreen(selectedGender: currentGender);
}

class _ChangeGenderScreen extends State<ChangeGenderScreen> {
  String selectedGender = '';

  _ChangeGenderScreen({required this.selectedGender});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenderBloc(selectedGender),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainBackground,
          title: const Text('Пол'),
        ),
        body: Container(
          color: AppColors.mainBackground,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 3.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Пол:"),
                        SizedBox(
                          width: 140,
                          child: RadioListTile(
                            title: const Text(
                              "Мужской",
                              style: TextStyle(fontSize: 15),
                            ),
                            value: "Мужской",
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value.toString();
                              });
                            },
                            dense: true,
                            contentPadding: EdgeInsets.all(5),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: RadioListTile(
                            title: const Text("Женский",
                            style: TextStyle(
                              fontSize: 15
                            ),),
                            value: "Женский",
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value.toString();
                              });
                            },
                            dense: true,
                            contentPadding: EdgeInsets.all(5),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                BlocBuilder<GenderBloc, GenderState>(
                  builder: (context, state) {
                    if (state is GenderInitial) {
                      return changeButton(context);
                    } else if (state is GenderChanging) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GenderFailure) {
                      return const Text("Пол не удалось изменить");
                    }
                    if (state is GenderChanged) {
                      return Column(
                        children: [
                          changeButton(context),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Пол успешно изменен",
                          ),
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

  Widget changeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.textColor1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () {
          context.read<GenderBloc>().add(ChangeGender(selectedGender));
        },
        child: const Text(
          'Изменить пол',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
