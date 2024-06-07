import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/domain/api_client/event_api_client.dart';
import 'package:travel_app/domain/blocs/event_bloc/event_list_bloc.dart';
import 'package:travel_app/ui/pages/widget/event_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _SearchPage()),
    );
  }


}

class _SearchPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AppBar(),
        // _SearchBar(),
        _CalendarBar(),
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

class _SearchBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Search',
            suffixIcon: Icon(Icons.search)
          ),
        )
      ],
    );
  }

}

class _CalendarBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container();
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
