import 'package:flutter/material.dart';
import 'package:travel_app/domain/factories/screen_factory.dart';

abstract class MainNavigationRouteNames {
  static const loaderWidget = '/';
  static const welcome = '/welcome';
  static const auth = '/auth';
  static const signup = '/signup';
  static const mainScreen = '/main_screen';
  static const eventDetails = '/main_screen/event_details';
  static const settings = '/main_screen/settings';
  static const uploadUser = '/main_screen/user/upload';
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
    MainNavigationRouteNames.uploadUser: (_) => _screenFactory.makeSettingsPage(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.eventDetails:
        final arguments = settings.arguments;
        final eventId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeEventDetails(eventId),
        );
      case MainNavigationRouteNames.settings:
        return MaterialPageRoute(
            builder: (_) => _screenFactory.makeSettingsPage(),
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
  static void searchNavigation(BuildContext context) {
    _screenFactory.makeSearchPage();
  }
}