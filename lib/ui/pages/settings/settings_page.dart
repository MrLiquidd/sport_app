import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/domain/model/user_model/user_model.dart';
import 'package:travel_app/domain/services/auth_service/auth_service.dart';
import 'package:travel_app/ui/navigation/main_navigation.dart';
import 'package:travel_app/ui/pages/settings/settings_bloc/setting_bloc.dart';
import 'package:travel_app/ui/theme/colors.dart';

import 'settings_pages/change_phone/change_phone.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingBloc()..add(LoadSetting()),
      child: const Scaffold(
        body: SafeArea(
          child: SettingsPageBloc(),
        ),
      ),
    );
  }
}

class SettingsPageBloc extends StatelessWidget {
  const SettingsPageBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          if (state is SettingLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SettingLoadSuccess) {
            return SettingsView(user: state.user);
          } else {
            return const Center(child: Text('Не удалось загрузить данные пользователя'));
          }
        },
      ),
    );
  }
}



class SettingsView extends StatelessWidget{
  final UserModel user;
  const SettingsView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: Container(
        color: AppColors.mainBackground,
        child: ListView(
          padding: const EdgeInsets.all(14.0),
          children: [
            const Text(
              'Учетные данные',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8.0),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: Column(
                children: [
                  ListTile(
                    onTap: (){
                      Navigator.of(context).pushNamed(
                        MainNavigationRouteNames.changePhone,
                        arguments: user.mobile
                      );
                    },
                    title: const Text('Телефон'),
                    subtitle: Text(user.mobile),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){
                      Navigator.of(context).pushNamed(
                        MainNavigationRouteNames.changeBirth,
                        arguments: user.born_date,
                      );
                    },
                    title: const Text('Дата рождения'),
                    subtitle: Text("${user.born_date.year.toString()}-${user.born_date.month.toString().padLeft(2,'0')}-${user.born_date.day.toString().padLeft(2,'0')}"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){
                      Navigator.of(context).pushNamed(
                        MainNavigationRouteNames.changeGender,
                        arguments: user.gender,
                      );
                    },
                    title: const Text('Пол'),
                    subtitle:  Text(user.gender),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Аккаунт',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8.0),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  ListTile(
                    onTap: (){},
                    title: const Text('Сменить пароль'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){
                      AuthService().logout();
                      MainNavigation.resetNavigation(context);
                    },
                    title: const Text('Выйти из аккаунта'),
                    trailing: const Icon(Icons.logout),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Вопросы',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8.0),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  ListTile(
                    onTap: (){},
                    title: const Text('Техподдержка'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){},
                    title: const Text('О приложении'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                onTap: (){},
                title: const Center(
                  child: Text(
                    'Удалить аккаунт',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                trailing: const Icon(Icons.delete, color: Colors.red),
              ),
            ),
            const SizedBox(height: 16.0),
            const Center(
              child: Text(
                'Наши соц сети',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.telegram, color: Colors.blue, size: 40),
                SizedBox(width: 16.0),
                Icon(Icons.vpn_key, color: Colors.blue, size: 40), // VK Icon
              ],
            ),
          ],
        ),
      ),
    );
  }

}