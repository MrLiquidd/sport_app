import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/domain/cubit/app_cubit_states.dart';
import 'package:travel_app/domain/cubit/app_cubits.dart';
import 'package:travel_app/ui/pages/details/detail_page.dart';
import 'package:travel_app/ui/pages/loader/loaded_page.dart';
import 'package:travel_app/ui/pages/welcome_page.dart';

import '../../ui/navigation/navigation_bar.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({super.key});

  @override
  State<AppCubitLogics> createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state){
          if(state is WelcomeState){
            return WelcomePage();
          }
          // if(state is LoadedState){
          //   return NavigationBarPage();
          // }
          if(state is LoadingState){
            return LoadedPage();
          }if(state is DetailState){
            return DetailPage();
          }else
            return Container();
        },
      ),
    );
  }
}
