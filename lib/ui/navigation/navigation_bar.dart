import 'package:flutter/material.dart';
import 'package:travel_app/domain/factories/screen_factory.dart';
import 'package:travel_app/ui/theme/colors.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  final _screenFactory = ScreenFactory();

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedTab,
        children: [
          _screenFactory.makeHomePage(),
          _screenFactory.makeSearchPage(),
          _screenFactory.makeBarItem(),
          _screenFactory.makeMyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        selectedItemColor: AppColors.textColor1,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_tennis), label: "Bar"),
          BottomNavigationBarItem(icon: Icon(Icons.library_books_outlined), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Me"),
        ],
        onTap: onSelectTab,
      ),
    );
  }
}

