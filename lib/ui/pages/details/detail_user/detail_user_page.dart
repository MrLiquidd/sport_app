
import 'package:flutter/material.dart';
import 'package:travel_app/domain/model/user_info_model/user_info_model.dart';
import 'package:travel_app/ui/cards/user_card.dart';
import 'package:travel_app/ui/elements/app_large_text.dart';
import 'package:travel_app/ui/theme/colors.dart';

class UserDetailPage extends StatelessWidget{
  final UserInfoModel user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children:  [
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
              'Назад',
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
        child: UserProfilePage(user: user,),
      ),
    );
  }
}

class UserProfilePage extends StatelessWidget{
  final UserInfoModel user;
  const UserProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserCard(user: user),
        const SizedBox(height: 15,),
        _addFriend(context)
      ],
    );
  }

  Widget _addFriend(BuildContext context){
    const double width = 350;
    return Flexible(
      child: GestureDetector(
        onTap: (){
        },
        child: Container(
          width: width,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Добавить в друзья",
                   style: TextStyle(
                     color: AppColors.textColor1,
                     fontSize: 14,
                     fontWeight: FontWeight.w400
                   ),
                ),
                Icon(Icons.add, color: AppColors.textColor1,
                size: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}