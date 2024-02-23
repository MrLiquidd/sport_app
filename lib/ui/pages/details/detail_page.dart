import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/domain/blocs/detail_bloc/app_cubit_states.dart';
import 'package:travel_app/domain/blocs/detail_bloc/app_cubits.dart';
import 'package:travel_app/ui/theme/colors.dart';
import 'package:travel_app/ui/elements/app_buttons.dart';
import 'package:travel_app/ui/elements/app_large_text.dart';
import 'package:travel_app/ui/elements/app_text.dart';
import 'package:travel_app/ui/elements/responsive_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int gottenStars = 4;
  int selectedIndex = 4;

  List icons = [Icons.local_parking, Icons.bedroom_child, Icons.wifi];
  List textCom = ['Парковка', 'Можно с ребенком', 'Бесплатный Wi-Fi'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      DetailState detail = state as DetailState;
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image(
                  image: NetworkImage(
                    "http://mark.bslmeiyu.com/uploads/" + detail.place.img,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              buttonArrow(context),
              scroll(context, detail),
              Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    children: [
                      AppButtons(
                          size: 60,
                          color: AppColors.textColor1,
                          backgroundColor: Colors.white,
                          borderColor: AppColors.textColor1,
                          icon: Icons.favorite_border,
                          isIcon: true),
                      const SizedBox(
                        width: 20,
                      ),
                      ResponsiveButton(
                        isResposive: true,
                      )
                    ],
                  ))
            ],
          ),
        ),
      );
    });
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          BlocProvider.of<AppCubits>(context).goHome();
        },
        child: Container(
            clipBehavior: Clip.hardEdge,
            width: 55,
            height: 55,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 55,
                width: 55,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(25)),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            )),
      ),
    );
  }

  scroll(context, detail) {
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 1.0,
        minChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 5,
                            width: 35,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                    ),
                    //About event title
                    AppLargeText(
                      text: 'О Событии',
                      size: 18,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    //description
                    Container(
                        child: AppText(
                      text: detail.place.description,
                      color: AppColors.mainTextColor,
                      size: 14,
                    )),
                    const SizedBox(
                      height: 18,
                    ),
                    //About event card
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 20),
                      width: double.maxFinite,
                      height: 272,
                      decoration: BoxDecoration(
                          color: AppColors.mainBackground,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Количство участников',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14),
                              ),
                              Text(
                                '10-12',
                                style: TextStyle(
                                    color: AppColors.textColor1,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Длительность',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14),
                              ),
                              Text(
                                '1,5-2 часа',
                                style: TextStyle(
                                    color: AppColors.textColor1,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Стоимость',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14),
                              ),
                              Text(
                                detail.place.price.toString(),
                                style: const TextStyle(
                                    color: AppColors.textColor1,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Возрасть',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14),
                              ),
                              Text(
                                '14+',
                                style: TextStyle(
                                    color: AppColors.textColor1,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Уровень игры',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14),
                              ),
                              Wrap(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    Icons.star,
                                    color: index < detail.place.stars
                                        ? AppColors.starColor
                                        : AppColors.textColor2,
                                  );
                                }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 42,
                    ),
                    //Comfort Title
                    AppLargeText(
                      text: 'Удобства',
                      size: 18,
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    //Comfort Grid
                    SizedBox(
                      width: double.maxFinite,
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 180,
                                    childAspectRatio: 3 / 1,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 5),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 1),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      icons[index],
                                      size: 24,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                        child: AppText(
                                      text: textCom[index],
                                      size: 16,
                                      color: Colors.black,
                                    ))
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 42,
                    ),
                    // Trainer Title
                    AppLargeText(
                      text: 'Тренер',
                      size: 18,
                    ),
                    // Trainer Card
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 20),
                        width: double.maxFinite,
                        height: 272,
                        decoration: BoxDecoration(
                            color: AppColors.mainBackground,
                            borderRadius: BorderRadius.circular(12)),
                        child: Container())
                  ],
                ),
              ));
        });
  }
}