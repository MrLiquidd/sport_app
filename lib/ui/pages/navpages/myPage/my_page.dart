import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/navigation/main_navigation.dart';
import 'package:travel_app/ui/cards/user_card.dart';
import 'package:travel_app/ui/theme/colors.dart';

import 'updateUser_page.dart';
import 'user_bloc/user_bloc.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      UserBloc()..add(LoadUser()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.mainBackground,
            appBar: AppBar(
              leading: TextButton(
                  onPressed: () async {
                    final result = await Navigator.of(context).push(_createRoute(state));
                    if (result == true) {
                      context.read<UserBloc>().add(LoadUser());
                    }
                  },
                  child: const Text(
                    'Изм.',
                    style: TextStyle(
                        color: AppColors.textColor1
                    ),
                  )
              ),
              leadingWidth: 100,
              actions: [
                IconButton(
                    color: Colors.grey,
                    iconSize: 30,
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        MainNavigationRouteNames.settings,
                      );
                    },
                    icon: const Icon(Icons.settings)),
                const SizedBox(width: 15,),
              ],
            ),
            body: const SafeArea(
              child: UserProfilePage(),
            ),
          );
        },
      ),
    );
  }

  Route _createRoute(state) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ProfilePage(user: state.user),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        var fadeTween = Tween(begin: 0.0, end: 1.0).chain(
            CurveTween(curve: curve));
        var fadeAnimation = animation.drive(fadeTween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: child,
          ),
        );
      },
    );
  }
}

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserLoadSuccess) {
          return UserCard(user: state.user);
        } else {
          return const Center(
              child: Text('Не удалось загрузить данные пользователя'));
        }
      },
    );
  }
}
