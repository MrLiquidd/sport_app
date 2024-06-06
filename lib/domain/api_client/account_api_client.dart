import 'package:travel_app/domain/api_client/network_client.dart';
import 'package:travel_app/domain/data_providers/session_data_provider.dart';
import 'package:travel_app/domain/model/user_info_model/user_info_model.dart';
import 'package:travel_app/domain/model/user_model/user_model.dart';

// enum MediaType { movie, tv }
//
// extension MediaTypeAsString on MediaType {
//   String asString() {
//     switch (this) {
//       case MediaType.movie:
//         return 'movie';
//       case MediaType.tv:
//         return 'tv';
//     }
//   }
// }

class AccountApiClient {
  final _networkClient = NetworkClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<String> getAccountInfo(
      String accessId,
      ) async {
    String parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['id'] as String;
      return result;
    }

    final parameters = <String, dynamic>{
      'accessId': accessId!,
    };

    final result = _networkClient.get(
      '/account',
      parameters,
      parser,
    );
    return result;
  }


  Future<UserModel> getUserSettingsInfo(
      ) async {
    final accessId = await _sessionDataProvider.getAccessId();

    UserModel parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = UserModel.fromJson(jsonMap);
      return response;
    }
    final parameters = <String, dynamic>{
      'accessId': accessId!,
    };

    final result = _networkClient.get(
      '/account',
      parameters,
      parser,
    );
    return result;
  }

  Future<UserInfoModel> getUserInfo(
      ) async {
    final accountId = await  _sessionDataProvider.getAccountId();
    final accessId = await _sessionDataProvider.getAccessId();

    UserInfoModel parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = UserInfoModel.fromJson(jsonMap);
      return response;
    }
    final parameters = <String, dynamic>{
      'accessId': accessId!,
    };

    final result = _networkClient.get(
        '/user-info/$accountId',
        parameters!,
        parser,
      );
    return result;
  }



  // Future<int> markAsFavorite({
  //   required int accountId,
  //   required String sessionId,
  //   required MediaType mediaType,
  //   required int mediaId,
  //   required bool isFavorite,
  // }) async {
  //   int parser(dynamic json) {
  //     return 1;
  //   }
  //
  //   final parameters = <String, dynamic>{
  //     'media_type': mediaType.asString(),
  //     'media_id': mediaId,
  //     'favorite': isFavorite,
  //   };
  //   final result = _networkClient.post(
  //     '/account/$accountId/favorite',
  //     parameters,
  //     parser,
  //     <String, dynamic>{
  //       'api_key': Configuration.apiKey,
  //       'session_id': sessionId,
  //     },
  //   );
  //   return result;
  // }
}
