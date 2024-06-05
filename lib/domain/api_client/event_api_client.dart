import 'package:travel_app/domain/data_providers/session_data_provider.dart';
import 'package:travel_app/domain/model/event_model/event_model.dart';

import 'network_client.dart';

class EventApiClient {
  final _networkClient = NetworkClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<List<Event>> getAllEvents() async {
    final accessId = await _sessionDataProvider.getAccessId();

    List<Event> parser(dynamic json) {
      final List<Event> events = [];
      final jsonList = json as List<dynamic>;
      for (var jsonItem in jsonList) {
        events.add(Event.fromJson(jsonItem as Map<String, dynamic>));
      }
      return events;
    }

    final result = await _networkClient.get(
        '/events/',
        accessId!,
        parser
    );
    return result;
  }

  Future<List<Event>> getGames() async {
    final accessId = await _sessionDataProvider.getAccessId();

    List<Event> parser(dynamic json) {
      final List<Event> events = [];
      final jsonList = json as List<dynamic>;
      for (var jsonItem in jsonList) {
        events.add(Event.fromJson(jsonItem as Map<String, dynamic>));
      }
      return events;
    }

    final result = await _networkClient.get(
        '/events/games/',
        accessId!,
        parser
    );
    return result;
  }

  Future<List<Event>> getTrainings() async {
    final accessId = await _sessionDataProvider.getAccessId();

    List<Event> parser(dynamic json) {
      final List<Event> events = [];
      final jsonList = json as List<dynamic>;
      for (var jsonItem in jsonList) {
        events.add(Event.fromJson(jsonItem as Map<String, dynamic>));
      }
      return events;
    }

    final result = await _networkClient.get(
        '/events/trainings/',
        accessId!,
        parser
    );
    return result;
  }

  Future<List<Event>> getRecentEvents() async {

    final accessId = await _sessionDataProvider.getAccessId();

    List<Event> parser(dynamic json) {
      final jsonList = json as List<dynamic>;
      final List<Event> events = [];
      for (var jsonItem in jsonList) {
        events.add(Event.fromJson(jsonItem as Map<String, dynamic>));
      }
      return events;
    }

    final result = await _networkClient.get(
        '/events/recent/',
        accessId!,
        parser
    );
    return result;
  }
}
