import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/domain/api_client/event_api_client.dart';
import 'package:travel_app/domain/blocs/event_bloc/event_list_bloc.dart';
import 'package:travel_app/domain/services/auth_service/auth_service.dart';
import 'package:travel_app/ui/navigation/main_navigation.dart';
import 'package:travel_app/ui/cards/event_card.dart';
import 'package:travel_app/ui/pages/navpages/homePage/stories/story_page.dart';
import 'package:travel_app/ui/theme/colors.dart';
import 'package:travel_app/ui/elements/app_large_text.dart';

import 'map/google_map.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainBackground,
        body: SingleChildScrollView(
          child: Container(
            color: AppColors.mainBackground,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Header
                _HomeHeaderWidget(),
                const StoryPage(),
                //New trains Text
                Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: AppLargeText(
                      text: 'Новые занятия',
                      size: 18,
                    )),
                _LoadEvents(),
                InkWell(
                  onTap: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          print("Do something!!!");
                        },
                        child: const Text(
                          'Cмотреть все',
                          style: TextStyle(
                              color: AppColors.textColor1,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_right,
                        color: AppColors.textColor1,
                        weight: 500,
                        size: 28,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: AppLargeText(
                      text: 'Карта',
                      size: 18,
                    )),
                SizedBox(height: 15,),
                _GoogleMap(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}

class _HomeHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppLargeText(
            text: "Главная",
            size: 24,
          ),
          Row(
            children: [
              // IconButton(
              //     color: Colors.grey,
              //     iconSize: 30,
              //     onPressed: () {
              //       AuthService().logout();
              //     },
              //     icon: const Icon(Icons.notifications)),
              IconButton(
                  iconSize: 30,
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      MainNavigationRouteNames.userFavorites,
                    );
                  },
                  icon: const Icon(Icons.favorite)),
            ],
          ),
        ],
      ),
    );
  }
}

class _LoadEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsBloc(EventApiClient())..add(LoadEvents()),
      child: BlocBuilder<EventsBloc, EventListState>(
        builder: (context, state) {
          if (state is EventsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EventsLoaded) {
            return Column(
              children: List.generate(
                state.events.length,
                (index) {
                  return EventCard(event: state.events[index]);
                },
              ),
            );
          } else if (state is EventsError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class _GoogleMap extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: CustomMap(),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return CirclePainter(color: color, radius: radius);
  }
}

class CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  CirclePainter({
    required this.color,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;

    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);

    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
