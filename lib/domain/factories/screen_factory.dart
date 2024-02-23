import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/domain/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/domain/blocs/auth_bloc/auth_states.dart';
import 'package:travel_app/ui/pages/auth/auth_model.dart';
import 'package:travel_app/ui/pages/auth/auth_widget.dart';
import 'package:travel_app/ui/pages/loader/loaded_page.dart';
import 'package:travel_app/ui/pages/loader/loader_view_model.dart';
import 'package:travel_app/ui/navigation/navigation_bar.dart';
import 'package:travel_app/ui/pages/navpages/bar_item_page.dart';
import 'package:travel_app/ui/pages/navpages/home_page.dart';
import 'package:travel_app/ui/pages/navpages/my_page.dart';
import 'package:travel_app/ui/pages/navpages/search_page.dart';

class ScreenFactory {

  AuthBloc? _authBloc;

  Widget makeLoader() {
    final authBloc = _authBloc ?? AuthBloc(AuthCheckStatusInProgressState());
    _authBloc = authBloc;
    return BlocProvider<LoaderViewCubit>(
      create: (context) =>
          LoaderViewCubit(LoaderViewCubitState.unknown, authBloc),
      lazy: false,
      child: const LoadedPage(),
    );
  }

  Widget makeAuth() {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: const AuthWidget(),
    );
  }

  Widget makeMainScreen() {
    _authBloc?.close();
    _authBloc = null;
    return const MainScreenWidget();
  }

  // Widget makeMovieDetails(int movieId) {
  //   return ChangeNotifierProvider(
  //     create: (_) => MovieDetailsModel(movieId),
  //     child: const MovieDetailsWidget(),
  //   );
  // }


  Widget makeHomePage() {
    return const HomePage();
  }

  Widget makeBarItem() {
    return const BarItemPage();
  }

  Widget makeSearchPage() {
   return const SearchPage();
  }

  Widget makeMyPage() {
    return const MyPage();
  }
}