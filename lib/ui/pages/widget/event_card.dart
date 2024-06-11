import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/configuration/configuration.dart';
import 'package:travel_app/domain/model/event_model/event_model.dart';
import 'package:travel_app/ui/navigation/main_navigation.dart';
import 'package:travel_app/ui/pages/details/detail_page.dart';
import 'package:travel_app/ui/theme/colors.dart';


class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailView(id: event.id,),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Text(event.eventType,
                          style: const TextStyle(
                              color: Colors.teal,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Roboto',
                          ))),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.group_outlined,color: AppColors.cardText,),
                      Text("${event.user_count}/${event.quantity}",
                      style: const TextStyle(
                        color: AppColors.cardText,
                        fontWeight: FontWeight.w500
                      )),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6,),
            Card(
              elevation: 0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                _avatar(),
                                const SizedBox(width: 10,),
                                Text(event.title,
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    softWrap: true,
                                    overflow: TextOverflow.visible
                                ),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5F5FA), // Цвет фона текста
                                    borderRadius: BorderRadius.circular(10.0), // Радиус закругления углов
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${event.date.hour}:${event.date.minute.toString().padLeft(2, '0')} ",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textColor1,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Text(formatEventDate(event.date),
                                  style: const TextStyle(
                                    fontSize: 14
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                        color: Colors.black38,),
                        Text(event.full_addresses,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black38
                        ),),
                        const Spacer(),
                        Text("${event.price} ₽",
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColors.cardText,
                            fontWeight: FontWeight.w600
                          ),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _avatar() {
    return event.photoId.isNotEmpty
        ? CircleAvatar(
      radius: 20,
      backgroundColor: Colors.transparent,
      backgroundImage: NetworkImage('${Configuration.host}/images/${event.photoId}'),
    )
        : const CircleAvatar(
      radius: 50,
      backgroundColor: Colors.transparent,
      child: Icon(Icons.person),
    );
  }

  String formatEventDate(DateTime date) {
    String dayOfWeek = DateFormat('EEEE', 'ru_RU').format(date);
    String capitalizedDayOfWeek = dayOfWeek[0].toUpperCase() + dayOfWeek.substring(1);
    return "$capitalizedDayOfWeek, ${date.day}.${date.month}";
  }

}
