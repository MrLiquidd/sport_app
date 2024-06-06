import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/configuration/configuration.dart';
import 'package:travel_app/domain/blocs/event_bloc/event_list_bloc.dart';
import 'package:travel_app/domain/model/event_model/event_model.dart';
import 'package:travel_app/ui/navigation/main_navigation.dart';
import 'package:travel_app/ui/theme/colors.dart';
import 'package:travel_app/ui/elements/app_buttons.dart';
import 'package:travel_app/ui/elements/app_large_text.dart';
import 'package:travel_app/ui/elements/app_text.dart';
import 'package:travel_app/ui/elements/responsive_button.dart';

import 'detail_bloc/detail_bloc.dart';

class DetailView extends StatelessWidget {
  final String id;

  const DetailView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      EventDetailBloc()..add(FetchEventDetail(id)),
      child: Scaffold(
        body: BlocBuilder<EventDetailBloc, EventDetailState>(
          builder: (context, state) {
            if (state is EventDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EventDetailLoaded) {
              return _DetailPageState(event: state.event);
            } else if (state is EventDetailError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }
}


class _DetailPageState extends StatelessWidget {

  final Event event;
  final int gottenStars = 4;
  final int selectedIndex = 4;

  final List icons = [Icons.local_parking, Icons.bedroom_child, Icons.wifi];
  final List textCom = ['Парковка', 'Можно с ребенком', 'Бесплатный Wi-Fi'];

  _DetailPageState({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Container(
                color: Colors.black,
                child: Image(
                  image: NetworkImage('${Configuration.host}${event.photoId}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            buttonArrow(context),
            _scroll(event, icons, textCom),
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
  }
}

Widget buttonArrow(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          MainNavigationRouteNames.mainScreen,
        );
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

Widget _scroll(Event event, icons, textCom) {
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
                  AppText(
                    text: event.about,
                    color: AppColors.mainTextColor,
                    size: 14,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  //About event card
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    width: double.maxFinite,
                    height: 272,
                    decoration: BoxDecoration(
                        color: AppColors.mainBackground,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Количство участников',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14),
                            ),
                            Text(
                              '${event.user_count}-${event.quantity}',
                              style: const TextStyle(
                                  color: AppColors.textColor1,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
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
                              event.price.toString(),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Возраст',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14),
                            ),
                            Text(
                              event.minAge.toString(),
                              style: const TextStyle(
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
                                  color: index < 0 //detail.place.stars
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