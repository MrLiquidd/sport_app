import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/domain/api_client/event_api_client.dart';
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
              fontWeight: FontWeight.w500,
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
          child: _TrainsPage()),
    );
  }


}

class _TrainsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LoadEvents(),
      ],
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