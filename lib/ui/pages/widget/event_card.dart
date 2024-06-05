import 'package:flutter/material.dart';
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
            builder: (context) => DetailView(event: event,),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(event.eventType, style: const TextStyle(color: Colors.teal)),
                const Spacer(),
                Text("0/${event.quantity}"),
              ],
            ),
            Card(
              elevation: 0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
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
                                    color: Colors.grey.withOpacity(0.1), // Цвет фона текста
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
                                Text("${DateFormat('EEEE', 'ru_RU').format(event.date)}, ${event.date.day}.${event.date.month}"),
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
                            fontSize: 16,
                            color: Colors.black,
                          ),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
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
      backgroundImage: NetworkImage('${Configuration.host}${event.photoId}'),
    )
        : const CircleAvatar(
      radius: 50,
      backgroundColor: Colors.transparent,
      child: Icon(Icons.person),
    );
  }
}
