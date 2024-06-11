
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/theme/colors.dart';

import 'birth_bloc.dart';

class ChangeBirthScreen extends StatefulWidget {
  final DateTime currentBirth;

  ChangeBirthScreen({super.key, required this.currentBirth});

  @override
  State<ChangeBirthScreen> createState() => _ChangeBirthScreenState(currentBirth: currentBirth);
}

class _ChangeBirthScreenState extends State<ChangeBirthScreen> {
  DateTime currentBirth;
  final TextEditingController _dateController = TextEditingController();

  _ChangeBirthScreenState({required this.currentBirth});

  @override
  void initState() {
    super.initState();
    _dateController.text = "${currentBirth.toLocal()}".split(' ')[0];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentBirth,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != currentBirth) {
      setState(() {
        currentBirth = picked;
        _dateController.text = "${currentBirth.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BirthBloc(widget.currentBirth),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainBackground,
          title: const Text('Дата рождения'),
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
                  child: TextField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Дата рождения',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () => _selectDate(context),
                  ),
                ),
                const SizedBox(height: 32.0),
                BlocBuilder<BirthBloc, BirthState>(
                  builder: (context, state) {
                    if(state is BirthInitial){
                      return changeButton(context);
                    }
                    else if (state is BirthChanging){
                      return const Center(child: CircularProgressIndicator());
                    } else if(state is BirthFailure){
                      return const Text("Дату рождения не удалось изменить");
                    }
                    if(state is BirthChanged){
                      return Column(
                        children: [
                          changeButton(context),
                          const SizedBox(height: 10,),
                          const Text("Дата рождения успешно изменена",),
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
          context.read<BirthBloc>().add(ChangeBirth(currentBirth));
        },
        child: const Text(
          'Изменить дату рождения',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}