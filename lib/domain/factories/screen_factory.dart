import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/domain/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/domain/blocs/auth_bloc/auth_states.dart';
import 'package:travel_app/domain/blocs/signup_bloc/signup_bloc.dart';
import 'package:travel_app/ui/pages/auth/auth/auth_view_cubit.dart';
import 'package:travel_app/ui/pages/auth/auth/auth_widget.dart';
import 'package:travel_app/ui/pages/auth/signup/signup_view_cubit.dart';
import 'package:travel_app/ui/pages/auth/signup/signup_widget.dart';
import 'package:travel_app/ui/pages/favorite/favorite_page.dart';
import 'package:travel_app/ui/pages/loader/loaded_widget.dart';
import 'package:travel_app/ui/pages/loader/loader_view_cubit.dart';
import 'package:travel_app/ui/navigation/navigation_bar.dart';
import 'package:travel_app/ui/pages/navpages/myTrainsPage/my_trains_page.dart';
import 'package:travel_app/ui/pages/navpages/homePage/home_page.dart';
import 'package:travel_app/ui/pages/navpages/myPage/my_page.dart';
import 'package:travel_app/ui/pages/navpages/searchPage/search_page.dart';
import 'package:travel_app/ui/pages/settings/settings_page.dart';
import 'package:travel_app/ui/pages/settings/settings_pages/change_birth/change_birth.dart';
import 'package:travel_app/ui/pages/settings/settings_pages/change_gender/change_gender.dart';
import 'package:travel_app/ui/pages/settings/settings_pages/change_phone/change_phone.dart';
import 'package:travel_app/ui/pages/welcome_page.dart';

class ScreenFactory {

  AuthBloc? _authBloc;
  SignUpBloc? _signUpBloc;

  Widget makeWelcome(){
    return const WelcomePage();
  }
  Widget makeLoader() {
    final authBloc = _authBloc ?? AuthBloc(AuthCheckStatusInProgressState());
    _authBloc = authBloc;
    return BlocProvider<LoaderViewCubit>(
      create: (context) =>
          LoaderViewCubit(LoaderViewCubitState.unknown, authBloc),
      child: const LoadedPage(),
    );
  }
  Widget makeAuth() {
    final authBloc = _authBloc ?? AuthBloc(AuthCheckStatusInProgressState());
    _authBloc = authBloc;
    return BlocProvider<AuthViewCubit>(
      create: (_) => AuthViewCubit(AuthViewCubitFormFillInProgressState(), authBloc),
      child: const AuthWidget(),
    );
  }
  Widget makeSignUp(){
    final signUpBloc = _signUpBloc ?? SignUpBloc(SignUpCheckStatusInProgressState());
    _signUpBloc = signUpBloc;
    return BlocProvider<SignUpViewCubit>(
      create: (_) => SignUpViewCubit(SignUpViewCubitFormFillInProgressState(), signUpBloc),
      child: const SignUpWidget(),
    );
  }
  Widget makeMainScreen() {
    _authBloc?.close();
    _authBloc = null;
    return const MainScreenWidget();
  }
  Widget makeUserFavorites(){
    return const FavoritePage();
  }
  Widget makeHomePage() {
    return const HomePage();
  }
  Widget makeTrainingsPage() {
    return const myTrainingsPage();
  }
  Widget makeSearchPage() {
   return const SearchPage();
  }
  Widget makeMyPage() {
    return const MyPage();
  }
  Widget makeSettingsPage(){
    return const SettingsPage();
  }
  Widget makeChangePhone(currentPhone){
    return ChangePhoneScreen(currentPhone: currentPhone,);
  }
  Widget makeChangeGender(currentGender){
    return ChangeGenderScreen(currentGender: currentGender,);
  }
  Widget makeChangeBirth(currentBirth){
    return ChangeBirthScreen(currentBirth: currentBirth,);
  }
}