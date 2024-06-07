import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/configuration/configuration.dart';
import 'package:travel_app/domain/model/event_model/event_model.dart';
import 'package:travel_app/ui/theme/colors.dart';
import 'package:travel_app/ui/elements/app_large_text.dart';
import 'package:travel_app/ui/elements/app_text.dart';

import 'button_bloc/button_bloc.dart';
import 'detail_bloc/detail_bloc.dart';
import 'favorite_bloc/favorite_bloc.dart';

class DetailView extends StatelessWidget {
  final String id;

  const DetailView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EventDetailBloc()..add(FetchEventDetail(id)),
        ),
        BlocProvider(
          create: (context) => ButtonBloc()..add(FetchButtonEvent(id)),
        ),
        BlocProvider(
            create:(context) => FavoriteBloc()..add(FetchFavoriteEvent(id)))
      ],
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
        appBar: AppBar(
          title: Text(event.title,
            style: const TextStyle(
                fontWeight: FontWeight.w500
            ),),
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                // Share action
              },
            ),
            BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
                if(state is EventIsFavoriteState){
                   return IconButton(
                    icon: const Icon(Icons.favorite_outlined),
                    onPressed: () {
                      context.read<FavoriteBloc>().add(UnFavoriteEvent(event.id));
                    },
                  );
                } else if(state is EventUnFavoriteState){
                  return IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      context.read<FavoriteBloc>().add(AddFavoriteEvent(event.id));
                    },
                  );
                } else {
                  return const CircularProgressIndicator(
                    color: Colors.white,
                  );
                }
            },
          ),
          ],
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Container(
                color: Colors.black,
                child: Image(
                  image: NetworkImage(
                      '${Configuration.host}/images/${event.photoId}'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ), //images
            _scroll(event, icons, textCom),
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    _recordButton(event),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

Widget _recordButton(Event event) {
  return BlocBuilder<ButtonBloc, ButtonDetailState>(
      builder: (context, state) {
        if (state is EventButtonLoadingState) {
          return _isLoadingButtonState();
        } else if (state is EventButtonIsRecordState) {
          return _isRecordButtonState(context,event);
        } else if (state is EventButtonUnRecordState) {
          return _unRecordButtonState(context,event);
        } else if (state is EventButtonErrorState) {
          // Обработка ошибки здесь
        }
        return Container(); // Возвращаем пустой виджет по умолчанию
      },
  );
}

Widget _unRecordButtonState(BuildContext context,Event event) {
  const bool isResposive = true;
  const double width = 120;
  return Flexible(
    child: Container(
      width: isResposive == true ? double.maxFinite : width,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.textColor1
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                context.read<ButtonBloc>().add(RecordEvent(event.id));
              },
              child: AppLargeText(
                text: "Записаться", color: Colors.white, size: 18,))
        ],
      ),
    ),
  );
}

Widget _isRecordButtonState(BuildContext context,Event event) {
  const bool isResposive = true;
  const double width = 120;
  return Flexible(
    child: Container(
      width: isResposive == true ? double.maxFinite : width,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.redAccent
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                context.read<ButtonBloc>().add(UnRecordEvent(event.id));
              },
              child: AppLargeText(
                text: "Отменить запись", color: Colors.white, size: 18,))
        ],
      ),
    ),
  );
}

Widget _isLoadingButtonState() {
  const bool isResposive = true;
  const double width = 120;
  return Flexible(
    child: Container(
      width: isResposive == true ? double.maxFinite : width,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.textColor1
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: CircularProgressIndicator(
            color: Colors.white,
          ))
        ],
      ),
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
                  _aboutEvent(event),
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
                  _comfortGrid(textCom, icons),
                  const SizedBox(
                    height: 42,
                  ),
                  // Trainer Title
                  AppLargeText(
                    text: 'Тренер',
                    size: 18,
                  ),
                  // Trainer Card
                  _trainerCard(),
                ],
              ),
            ));
      });
}

Widget _aboutEvent(Event event) {
  return Container(
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
  );
}

Widget _comfortGrid(textCom, icons) {
  return SizedBox(
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
  );
}

Widget _trainerCard() {
  return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 40, horizontal: 20),
      width: double.maxFinite,
      height: 272,
      decoration: BoxDecoration(
          color: AppColors.mainBackground,
          borderRadius: BorderRadius.circular(12)),
      child: Container());
}