import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/configuration/configuration.dart';
import 'package:travel_app/domain/api_client/account_api_client.dart';
import 'package:travel_app/ui/pages/details/detail_user/detail_user_page.dart';
import 'package:travel_app/ui/theme/colors.dart';

import 'friends_bloc/friend_bloc.dart';

class FriendsPage extends StatelessWidget {
  FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FriendsBloc()..add(FetchFriends()),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 200,
          leading: Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Мои друзья',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18
                ),
              )
            ],
          ),
        ),
        backgroundColor: AppColors.mainBackground,
        body: SafeArea(
          child: Column(
            children: [
              searchBar(),
              friends(),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return BlocBuilder<FriendsBloc, FriendsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (query) {
              context.read<FriendsBloc>().add(SearchFriends(query));
            },
            decoration: InputDecoration(
              hintText: 'Поиск друзей...',
              hintStyle: const TextStyle(color: Colors.grey),
              // Цвет подсказки серый
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              // Цвет иконки серый
              filled: true,
              fillColor: Colors.grey[200],
              // Цвет фона серый, можно настроить под нужды
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0), // Округление углов
                borderSide: BorderSide.none, // Убираем рамку
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0), // Округление углов
                borderSide: BorderSide.none, // Убираем рамку
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0), // Округление углов
                borderSide: BorderSide.none, // Убираем рамку
              ),
            ),
          ),
        );
      },
    );
  }

  Widget friends() {
    return Expanded(
      child: BlocBuilder<FriendsBloc, FriendsState>(
        builder: (context, state) {
          if (state is FriendsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FriendsLoaded) {
            return ListView.builder(
              itemCount: state.friends.length,
              itemBuilder: (context, index) {
                final friend = state.friends[index];
                return ListTile(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailPage(user: state.friends[index],),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        '${Configuration.host}/images/${friend.photo_id}'),
                  ),
                  title: Text('${friend.first_name} ${friend.last_name}'),
                  // Дополнительные данные о друге, если нужно
                );
              },
            );
          } else if (state is FriendsError) {
            return Center(child: Text('Ошибка: ${state.errorMessage}'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
