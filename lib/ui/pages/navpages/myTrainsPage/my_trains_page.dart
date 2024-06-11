import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/domain/api_client/event_api_client.dart';
import 'package:travel_app/domain/model/event_model/event_model.dart';
import 'package:travel_app/ui/pages/widget/event_card.dart';
import 'package:travel_app/ui/theme/colors.dart';
import 'trains_bloc/trains_bloc.dart';

class myTrainingsPage extends StatelessWidget {
  const myTrainingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppBar(
        title: const Text('Расписание',
          style: TextStyle(
              fontWeight: FontWeight.w600,
          ),),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            color: Colors.black45,
            onPressed: () {
              // Share action
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            color: Colors.black45,
            onPressed: () {
              // Share action
            },
          ),
        ],
      ),
      body: SafeArea(
          child: _LoadEvents()),
    );
  }
}

class _LoadEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrainsListBloc(EventApiClient())..add(LoadTrainsEvents()),
      child: BlocBuilder<TrainsListBloc, TrainsListState>(
        builder: (context, state) {
          if (state is EventsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EventsLoaded) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    EventCard(event: state.events[index],),
                    _ShowQrCode(event: state.events[index],),
                    _DeleteButton(event: state.events[index],),
                  ],
                );
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

class _ShowQrCode extends StatelessWidget {
  final Event event;

  const _ShowQrCode({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: BlocBuilder<TrainsListBloc, TrainsListState>(
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                // context.read<TrainsListBloc>().add(UnFavoriteEvent(event.id));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Показать QR-code',
                    style: TextStyle(color: AppColors.textColor1),
                  ),
                  Icon(Icons.arrow_forward_ios, color: AppColors.textColor1,
                  size: 20,)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}

class _DeleteButton extends StatelessWidget {
  final Event event;

  const _DeleteButton({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: BlocBuilder<TrainsListBloc, TrainsListState>(
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                context.read<TrainsListBloc>().add(UnRecordEvent(event.id));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Отменить запись',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  Icon(Icons.close, color: Colors.redAccent,)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}