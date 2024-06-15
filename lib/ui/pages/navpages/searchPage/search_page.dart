import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/cards/event_card.dart';
import 'package:travel_app/ui/navigation/main_navigation.dart';
import 'package:travel_app/ui/theme/colors.dart';

import 'search_bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> items = ['Все занятия', 'Тренировки', 'Игры'];
  String currentItem = 'Все занятия';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc()..add(FetchAllEvents()),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 200,
          leading: DropdownMenu(),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                  iconSize: 30,
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      MainNavigationRouteNames.userFavorites,
                    );
                  },
                  icon: const Icon(Icons.favorite)),
            ),
          ],
        ),
        backgroundColor: AppColors.mainBackground,
        body: SafeArea(child: _SearchPage()),
      ),
    );
  }
}

class _SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _searchBar(),
        _CalendarBar(),
        _LoadEvents(),
      ],
    );
  }
  Widget _searchBar() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (query) {
              context.read<SearchBloc>().add(SearchQueryEvents(query));
            },
            decoration: InputDecoration(
              hintText: 'поиск',
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CalendarBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _LoadEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchLoaded) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: state.events.length,
            itemBuilder: (context, index) {
              return EventCard(event: state.events[index]);
            },
          );
        } else if (state is SearchError) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else {
          return Container();
        }
      },
    );
  }
}


class DropdownMenu extends StatefulWidget {
  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}
class _DropdownMenuState extends State<DropdownMenu> {
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = 'Все занятия';
  }

  @override
  Widget build(BuildContext context) {
    final SearchBloc searchBloc = BlocProvider.of<SearchBloc>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          dropdownColor: AppColors.mainBackground,
          value: selectedOption,
          icon: const Icon(Icons.arrow_drop_down,
              size: 32, color: Colors.black),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(
            fontSize: 20,
            backgroundColor: AppColors.mainBackground,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedOption = newValue;
              });
              // Определение события на основе выбранного значения
              if (newValue == 'Все занятия') {
                searchBloc.add(FetchAllEvents());
              } else if (newValue == 'Игры') {
                searchBloc.add(FetchGamesEvents());
              } else if (newValue == 'Тренировки') {
                searchBloc.add(FetchTrainsEvents());
              }
            }
          },
          items: <String>[
            'Все занятия',
            'Игры',
            'Тренировки',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}