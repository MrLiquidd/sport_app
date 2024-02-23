import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_app/domain/blocs/detail_bloc/app_cubits.dart';
import 'package:travel_app/ui/theme/colors.dart';
import 'package:travel_app/ui/elements/app_large_text.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = [
    "welcome-one.png",
    "welcome-two.png",
    "welcome-three.png",
  ];

  List texts = [
    'Mountain hikes give you an incredible sense of freedom along with endurance tests',
    '',
    '',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: SafeArea(
          child: Container(
            color: AppColors.mainBackground,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppLargeText(text: 'Добро Пожаловать!', size: 24,),
                  const SizedBox(height: 80,),
                  SvgPicture.asset('img/undraw_fans_re_cri3.svg',
                  width: 256,
                  height: 256,),
                  const SizedBox(height: 87,),
                  //Registration
                  GestureDetector(
                    onTap: (){
                      BlocProvider.of<AppCubits>(context).getData();
                    },
                    child: Container(
                      width: 300,
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                              width: double.maxFinite,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.textColor1
                              ),
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.center,
                                children: [
                                  Container(
                                      child: AppLargeText(text: "Зарегистрироваться", color: Colors.white, size: 18,))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  //Enter
                  GestureDetector(
                    onTap: (){
                      BlocProvider.of<AppCubits>(context).getData();
                    },
                    child: Container(
                      width: 300,
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                              width: double.maxFinite,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white
                              ),
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.center,
                                children: [
                                  Container(
                                      child: AppLargeText(text: "Войти", color: AppColors.textColor1, size: 18,))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
