import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/configuration/configuration.dart';
import 'package:travel_app/domain/model/user_info_model/user_info_model.dart';
import 'package:travel_app/ui/theme/colors.dart';

import 'edit_bloc/edit_bloc.dart';

class ProfilePage extends StatefulWidget {
  final UserInfoModel user;

  ProfilePage({required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _ageController;
  late String _selectedCity;
  late TextEditingController _aboutController;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.first_name);
    _lastNameController = TextEditingController(text: widget.user.last_name);
    _ageController = TextEditingController(text: widget.user.age.toString());
    _selectedCity = widget.user.city;
    _aboutController = TextEditingController(text: widget.user.about_me);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditBloc(),
      child: BlocBuilder<EditBloc, EditState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF7F7FF), // Цвет фона
            appBar: AppBar(
              leading: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Отмена',
                    style: TextStyle(
                        color: AppColors.textColor1
                    ),
                  )
              ),
              leadingWidth: 100,
              actions: [
                TextButton(
                    onPressed: () {
                      final profileData = {
                        'photo': _imageFile,
                        'first_name': _firstNameController.text,
                        'last_name': _lastNameController.text,
                        'age': int.parse(_ageController.text),
                        'city': _selectedCity,
                        'about_me': _aboutController.text,
                      };
                      context.read<EditBloc>().add(UpdateProfile(profileData: profileData));
                      // Закрыть экран и передать результат назад
                      Navigator.pop(context, true);
                    },
                    child: const Text(
                      'Готово',
                      style: TextStyle(
                          color: AppColors.textColor1
                      ),
                    )
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _avatar(),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _pickImage,
                    child: const Text(
                      'Выбрать фотографию',
                      style: TextStyle(
                        color: Color(0xFF018786), // Цвет текста
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ProfileTextField(
                      controller: _firstNameController, label: 'Имя'),
                  ProfileTextField(
                      controller: _lastNameController, label: 'Фамилия'),
                  ProfileTextField(
                      controller: _ageController,
                      label: 'Возраст',
                      keyboardType: TextInputType.number),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DropdownButtonFormField<String>(
                      value: _selectedCity,
                      decoration: InputDecoration(
                        labelText: 'Город',
                        labelStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      items: <String>[
                        'Казань',
                        'Москва',
                        'Санкт-Петербург',
                        'Новосибирск'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCity = newValue!;
                        });
                      },
                    ),
                  ),
                  ProfileTextField(
                      controller: _aboutController,
                      label: 'О себе',
                      maxLines: 3),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _avatar() {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.transparent,
      backgroundImage: _imageFile != null
          ? FileImage(_imageFile!)
          : NetworkImage(widget.user.photo_id.isNotEmpty
          ? '${Configuration.host}/images/${widget.user.photo_id}'
          : 'https://via.placeholder.com/150') as ImageProvider,
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
}

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int maxLines;
  final TextInputType keyboardType;

  ProfileTextField({required this.controller,
    required this.label,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
