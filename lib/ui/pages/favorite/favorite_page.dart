import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/domain/api_client/event_api_client.dart';
import 'package:travel_app/domain/model/event_model/event_model.dart';
import 'package:travel_app/ui/pages/widget/event_card.dart';
import 'package:travel_app/ui/theme/colors.dart';

import 'favorite_bloc/favorite_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppBar(
        title: const Text('Избранное',
          style: TextStyle(
              fontWeight: FontWeight.w500
          ),),
      ),
      body: SafeArea(
        child: _LoadEvents(),),
    );
  }
}


class _LoadEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      FavoriteListBloc(EventApiClient())
        ..add(LoadFavoriteEvents()),
      child: BlocBuilder<FavoriteListBloc, FavoriteListState>(
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
                    EventCard(event: state.events[index]),
                    _DeleteButton(event: state.events[index],)
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

class _DeleteButton extends StatelessWidget {
  final Event event;

  const _DeleteButton({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: BlocBuilder<FavoriteListBloc, FavoriteListState>(
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
                context.read<FavoriteListBloc>().add(UnFavoriteEvent(event.id));
              },
              child: const Text(
                'Удалить из избранного',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          );
        },
      ),
    );
  }

}
