import 'package:flutter/material.dart';
import 'package:travel_app/domain/factories/screen_factory.dart';
import 'package:travel_app/ui/pages/navpages/myPage/updateUser_page.dart';

abstract class MainNavigationRouteNames {
  static const loaderWidget = '/';
  static const welcome = '/welcome';
  static const auth = '/auth';
  static const signup = '/signup';
  static const mainScreen = '/main_screen';
  static const eventDetails = '/main_screen/event_details';
  static const uploadUser = '/main_screen/user/upload';
  static const userFavorites = '/main_screen/user/favorites';
  static const settings = '/main_screen/user/settings';

  static const changePhone = '/main_screen/user/settings/change_phone';
  static const changeGender = '/main_screen/user/settings/change_gender';
  static const changeBirth = '/main_screen/user/settings/change_birth';
  static const changePassword = '/main_screen/user/settings/change_password';

  static const friendsList = '/main_screen/user/friends';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.loaderWidget: (_) => _screenFactory.makeLoader(),
    MainNavigationRouteNames.welcome: (_) => _screenFactory.makeWelcome(),
    MainNavigationRouteNames.auth: (_) => _screenFactory.makeAuth(),
    MainNavigationRouteNames.signup: (_) => _screenFactory.makeSignUp(),
    MainNavigationRouteNames.mainScreen: (_) => _screenFactory.makeMainScreen(),
    MainNavigationRouteNames.settings: (_) => _screenFactory.makeSettingsPage(),
    MainNavigationRouteNames.userFavorites: (_) => _screenFactory.makeUserFavorites(),
    MainNavigationRouteNames.friendsList: (_) => _screenFactory.makeFriendsList(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.changePhone:
        final arguments = settings.arguments;
        final currentPhone = arguments is String ? arguments : 0;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeChangePhone(currentPhone),
        );
      case MainNavigationRouteNames.changeGender:
        final arguments = settings.arguments;
        final currentGender = arguments is String ? arguments : 0;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeChangeGender(currentGender),
        );
      case MainNavigationRouteNames.changeBirth:
        final arguments = settings.arguments;
        final currentBirth = arguments is DateTime ? arguments : 0;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeChangeBirth(currentBirth),
        );
      case MainNavigationRouteNames.changePassword:
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeChangePassword(),
        );
      default:
        const widget = Text('Navigation error!!!');
        return MaterialPageRoute(builder: (_) => widget);
    }
  }

  static void resetNavigation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      MainNavigationRouteNames.loaderWidget,
          (route) => false,
    );
  }
}