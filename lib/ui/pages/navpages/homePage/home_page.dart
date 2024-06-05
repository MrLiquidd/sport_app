import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_app/domain/api_client/auth_api_client.dart';
import 'package:travel_app/domain/api_client/event_api_client.dart';
import 'package:travel_app/domain/blocs/event_bloc/event_list_bloc.dart';
import 'package:travel_app/domain/services/auth_service/auth_service.dart';
import 'package:travel_app/domain/services/user_service/user_service.dart';
import 'package:travel_app/resources/resources.dart';
import 'package:travel_app/ui/navigation/main_navigation.dart';
import 'package:travel_app/ui/pages/widget/event_card.dart';
import 'package:travel_app/ui/theme/colors.dart';
import 'package:travel_app/ui/elements/app_large_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            color: AppColors.mainBackground,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Space between header and savearea
                const SizedBox(
                  height: 25,
                ),
                //Header
                _HomeHeaderWidget(),
                //Stories?
                _HomeStoriesWidget(),
                const SizedBox(
                  height: 34,
                ),
                //New trains Text
                Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: AppLargeText(
                      text: 'Новые занятия',
                      size: 18,
                    )),
                _LoadEvents(),
                 InkWell(
                  onTap: () {
                  },
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Cмотреть все',
                        style: TextStyle(color: AppColors.textColor1,
                            fontSize: 14, fontWeight: FontWeight.w500),),
                      Icon(Icons.arrow_right, color: AppColors.textColor1,
                        weight: 500, size: 28,)
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
                      size: 25,
                    )),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )
    );
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
          ),
          Row(
            children: [
              IconButton(
                  color: Colors.grey,
                  iconSize: 30,
                  onPressed: () {},
                  icon: const Icon(Icons.notifications)),
              IconButton(
                  iconSize: 30,
                  color: Colors.red,
                  onPressed: () {
                    // AuthApiClient().refreshToken();
                  },
                  icon: const Icon(Icons.favorite)),
            ],
          ),
        ],
      ),
    );
  }

}

class _HomeStoriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainBackground,
      padding: const EdgeInsets.only(left: 15, right: 15),
      height: 144,
      width: double.maxFinite,
      child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                width: 106,
                height: 144,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SvgPicture.asset(AppImages.fans3,
                  width: 124,
                  height: 148,
                ),
              ),
            );
          }),
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
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                return EventCard(event: state.events[index]);
              },
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
