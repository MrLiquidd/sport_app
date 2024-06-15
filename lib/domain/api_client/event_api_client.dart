import 'package:travel_app/domain/data_providers/session_data_provider.dart';
import 'package:travel_app/domain/model/event_model/event_model.dart';

import 'network_client.dart';

class EventApiClient {
  final _networkClient = NetworkClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<List<Event>> getAllEvents() async {
    final accessId = await _sessionDataProvider.getAccessJWTToken();

    List<Event> parser(dynamic json) {
      final List<Event> events = [];
      final jsonList = json as List<dynamic>;
      for (var jsonItem in jsonList) {
        events.add(Event.fromJson(jsonItem as Map<String, dynamic>));
      }
      return events;
    }
    final parameters = <String, dynamic>{
      'accessId': accessId!,
    };


    final result = await _networkClient.get(
        '/events/all',
        parameters,
        parser
    );
    return result;
  }
  Future<Event> getDetailEvent(String event_id) async{
    final accessId = await _sessionDataProvider.getAccessJWTToken();
    Event parser(dynamic json){
      final jsonMap = json as Map<String, dynamic>;
      final response = Event.fromJson(jsonMap);
      return response;
    }

    final parameters = <String, dynamic>{
      'accessId': accessId!,
    };

    final result = _networkClient.get(
      '/events/$event_id',
      parameters,
      parser,
    );
    return result;
  }

  Future<List<Event>> getGames() async {
    final accessId = await _sessionDataProvider.getAccessJWTToken();

    List<Event> parser(dynamic json) {
      final List<Event> events = [];
      final jsonList = json['events'] as List<dynamic>;
      for (var jsonItem in jsonList) {
        events.add(Event.fromJson(jsonItem as Map<String, dynamic>));
      }
      return events;
    }
    final parameters = <String, dynamic>{
      'accessId': accessId!,
    };

    final result = await _networkClient.get(
        '/events/games/',
        parameters,
        parser
    );
    return result;
  }
  Future<List<Event>> getTrainings() async {
    final accessId = await _sessionDataProvider.getAccessJWTToken();

    List<Event> parser(dynamic json) {
      final List<Event> events = [];
      final jsonList = json['events'] as List<dynamic>;
      for (var jsonItem in jsonList) {
        events.add(Event.fromJson(jsonItem as Map<String, dynamic>));
      }
      return events;
    }
    final parameters = <String, dynamic>{
      'accessId': accessId!,
    };

    final result = await _networkClient.get(
        '/events/trainings/',
        parameters,
        parser
    );
    return result;
  }
  Future<List<Event>> getRecentEvents() async {
    final accessId = await _sessionDataProvider.getAccessJWTToken();

    List<Event> parser(dynamic json) {
      final jsonList = json as List<dynamic>;
      final List<Event> events = [];
      for (var jsonItem in jsonList) {
        events.add(Event.fromJson(jsonItem as Map<String, dynamic>));
      }
      return events;
    }

    final parameters = <String, dynamic>{
      'accessId': accessId!,
    };

    final result = await _networkClient.get(
        '/events/recent/',
        parameters,
        parser
    );
    return result;
  }
  Future<List<Event>> getSearchEvents(
      String query
      ) async {
    final accessId = await _sessionDataProvider.getAccessJWTToken();

    List<Event> parser(dynamic json) {
      final List<Event> events = [];
      json = json['events'];
      final jsonList = json as List<dynamic>;
      for (var jsonItem in jsonList) {
        events.add(Event.fromJson(jsonItem as Map<String, dynamic>));
      }
      return events;
    }

    final parameters = <String, dynamic>{
      'accessId': accessId!,
    };

    final encodedQuery = Uri.encodeQueryComponent(query);
    final result = _networkClient.get(
      '/events/search/?search=$encodedQuery',
      parameters,
      parser,
    );
    return result;
  }


  Future<List<Event>> getRecordsEvents() async{
    final accessId = await _sessionDataProvider.getAccessJWTToken();
    final accountId = await _sessionDataProvider.getAccountId();

    List<Event> parser(dynamic json) {
      final List<Event> events = [];
      final jsonList = json as List<dynamic>;
      for (var jsonItem in jsonList) {
        events.add(Event.fromJson(jsonItem as Map<String, dynamic>));
      }
      return events;
    }
    final parameters = <String, dynamic>{
      'accessId': accessId!,
    };


    final result = await _networkClient.get(
        '/user/$accountId/visits/',
        parameters,
        parser
    );
    return result;
  }
  Future<bool> getRecordEvent(String event_id) async{
    final accessId = await _sessionDataProvider.getAccessJWTToken();
    final user_id = await _sessionDataProvider.getAccountId();

    bool parser(dynamic json){
      final jsonMap = json as Map<String, dynamic>;
      final status = jsonMap['exists'] as bool;
      return status;
    }

    final parameters = <String, dynamic>{
      'user_id': user_id,
      'event_id': event_id,
    };

    final result = await _networkClient.post(
        '/events/check-visit/',
        parameters,
        parser,
        accessId,
    );
    return result;


  }
  Future<bool> postRecordEvent(String event_id) async{
    final accessId = await _sessionDataProvider.getAccessJWTToken();
    final user_id = await _sessionDataProvider.getAccountId();

    bool parser(dynamic json){
      final jsonMap = json as Map<String, dynamic>;
      final status = jsonMap['exists'] as bool;
      return status;
    }

    final parameters = <String, dynamic>{
      'user_id': user_id,
      'event_id': event_id,
    };

    final result = await _networkClient.post(
        '/events/create-visit/',
        parameters,
        parser,
        accessId
    );
    return result;


  }
  Future<bool> deleteRecordEvent(String event_id) async{
    final accessId = await _sessionDataProvider.getAccessJWTToken();
    final user_id = await _sessionDataProvider.getAccountId();

    bool parser(dynamic json){
      final jsonMap = json as Map<String, dynamic>;
      final status = jsonMap['exists'] as bool;
      return status;
    };

    final parameters = <String, dynamic>{
      'user_id': user_id,
      'event_id': event_id,
    };

    final result = await _networkClient.post(
        '/events/delete-visit/',
        parameters,
        parser,
        accessId
    );
    return result;
  }

  Future<List<Event>> getFavoritesEvents() async{
    final accessId = await _sessionDataProvider.getAccessJWTToken();
    final accountId = await _sessionDataProvider.getAccountId();

    List<Event> parser(dynamic json) {
      final List<Event> events = [];
      final jsonList = json as List<dynamic>;
      for (var jsonItem in jsonList) {
        events.add(Event.fromJson(jsonItem as Map<String, dynamic>));
      }
      return events;
    }
    final parameters = <String, dynamic>{
      'accessId': accessId!,
    };


    final result = await _networkClient.get(
        '/user/$accountId/favorites/',
        parameters,
        parser
    );
    return result;
  }
  Future<bool> getFavoriteEvent(String event_id) async{
    final accessId = await _sessionDataProvider.getAccessJWTToken();
    final user_id = await _sessionDataProvider.getAccountId();

    bool parser(dynamic json){
      final jsonMap = json as Map<String, dynamic>;
      final status = jsonMap['exists'] as bool;
      return status;
    }

    final parameters = <String, dynamic>{
      'user_id': user_id,
      'event_id': event_id,
    };

    final result = await _networkClient.post(
      '/events/check-favorite/',
      parameters,
      parser,
      accessId,
    );
    return result;


  }
  Future<bool> postFavoriteEvent(String event_id) async{
    final accessId = await _sessionDataProvider.getAccessJWTToken();
    final user_id = await _sessionDataProvider.getAccountId();

    bool parser(dynamic json){
      final jsonMap = json as Map<String, dynamic>;
      final status = jsonMap['exists'] as bool;
      return status;
    }

    final parameters = <String, dynamic>{
      'user_id': user_id,
      'event_id': event_id,
    };

    final result = await _networkClient.post(
        '/events/create-favorite/',
        parameters,
        parser,
        accessId
    );
    return result;


  }
  Future<bool> deleteFavoriteEvent(String event_id) async{
    final accessId = await _sessionDataProvider.getAccessJWTToken();
    final user_id = await _sessionDataProvider.getAccountId();

    bool parser(dynamic json){
      final jsonMap = json as Map<String, dynamic>;
      final status = jsonMap['exists'] as bool;
      return status;
    };

    final parameters = <String, dynamic>{
      'user_id': user_id,
      'event_id': event_id,
    };

    final result = await _networkClient.post(
        '/events/delete-favorite/',
        parameters,
        parser,
        accessId
    );
    return result;
  }

}
