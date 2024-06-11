import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/domain/api_client/event_api_client.dart';
import 'package:travel_app/ui/pages/widget/event_card.dart';

import 'favorite_bloc/favorite_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное',
          style: TextStyle(
              fontWeight: FontWeight.w500
          ),),
      ),
      body: SafeArea(
          child: _FavoritePage()),
    );
  }


}

class _FavoritePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AppBar(),
        _LoadEvents(),
      ],
    );
  }
}

class _AppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container();
  }

}

class _LoadEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteListBloc(EventApiClient())..add(LoadFavoriteEvents()),
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
