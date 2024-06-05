import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_app/configuration/configuration.dart';
import 'package:travel_app/domain/model/user_info_model/user_info_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/navigation/main_navigation.dart';
import 'package:travel_app/ui/theme/colors.dart';

import 'user_bloc/user_bloc.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(LoadUser()),
      child: const Scaffold(
        body: SafeArea(
          child: UserProfilePage(),
        ),
      ),
    );
  }
}

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoadSuccess) {
            return ProfileView(user: state.user);
          } else {
            return const Center(child: Text('Не удалось загрузить данные пользователя'));
          }
        },
      ),
    );
  }
}



class ProfileView extends StatelessWidget{
  final UserInfoModel user;

  const ProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.mainBackground,
        child: Column(
          children: [
            _appBar(context),
            const SizedBox(height: 20,),
            Column(
              children: [
                _avatar(),
                const SizedBox(height: 24,),
                _username(),
                const SizedBox(height: 12,),
                userCity(context),
                const SizedBox(height: 26,),
                _aboutMe(),
                const SizedBox(height: 12,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _friends(),
                      const SizedBox(width: 10,),
                      _numEvents(),
                    ],
                  ),
                )
              ],
            ),
          ],
        )
    );
  }

  Widget _appBar(BuildContext context) {
    return Container(
      color: AppColors.mainBackground,
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  MainNavigationRouteNames.settings,
                );
              },
              child: const Text(
                  'Изменить',
                style: TextStyle(
                    color: AppColors.textColor1
                ),
              )
          ),
          IconButton(
              color: Colors.grey,
              iconSize: 30,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  MainNavigationRouteNames.settings,
                );
              },
              icon: const Icon(Icons.settings)),
        ],
      ),
    );
  }
  Widget _avatar() {
    return user.photo_id.isNotEmpty
        ? CircleAvatar(
      radius: 50,
      backgroundColor: Colors.transparent,
      backgroundImage: NetworkImage('${Configuration.host}${user.photo_id}'),
    )
        : const CircleAvatar(
      radius: 50,
      backgroundColor: Colors.transparent,
      child: Icon(Icons.person),
    );
  }
  Widget _username() {
    return Text('${user.first_name} ${user.last_name} ,${user.age}',
      style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500
      ),
    );
  }
  Widget userCity(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            color: Colors.grey,
            iconSize: 30,
            onPressed: () {
            },
            icon: const Icon(Icons.location_on)),
        Text(user.city,
          style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16
          ),),
      ],
    );
  }
  Widget _aboutMe() {
    return Container(
        constraints: const BoxConstraints(
            maxHeight: double.infinity
        ),
        width: 343,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child:  Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('О себе: ',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey
                  )),
              const SizedBox(width: 5,),
              Flexible(child:
              Text(user.about_me,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal
                ),))
            ],
          ),
        )
    );
  }
  Widget _friends() {
    return TextButton(
      onPressed: () {  },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 2.0,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('${user.friends_count}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                    color: Colors.black87
                )),
          ),
          const Center(
            child: Text('Друзей',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87
              ),),
          )
        ],
      ),
    );
  }
  Widget _numEvents() {
    return TextButton(
      onPressed: () {  },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 2.0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('4',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87
                )),
          ),
          Center(
            child: Text('Количество посещений',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87
              ),),
          )
        ],
      ),
    );
  }

}
