import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/domain/api_client/account_api_client.dart';
import 'package:travel_app/domain/model/user_info_model/user_info_model.dart';

part 'friend_event.dart';

part 'friend_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final friendsApiClient = AccountApiClient();

  FriendsBloc() : super(FriendsInitial()){
    on<FriendsEvent>((event, emit) async{
      if (event is FetchFriends) {
        await _onLoadFriends(event, emit);
      } else if (event is SearchFriends) {
       await _onSearchFriends(event, emit);
      }
    });
  }

  Future<void> _onLoadFriends(
      FetchFriends event,
      Emitter<FriendsState> emit) async {
    emit(FriendsLoading());
    try {
      final friends = await friendsApiClient.getFriendsList();
      emit(FriendsLoaded(friends));
    } catch (e) {
      emit(FriendsError(e.toString()));
    }
  }

  Future<void> _onSearchFriends(
      SearchFriends event,
      Emitter<FriendsState> emit) async{
    if (event.query.isEmpty) {
      emit(FriendsLoaded([]));
    } else {
      emit(FriendsLoading());
      try {
        final searchResults = await friendsApiClient.getFriendsSearchList(event.query);
        emit(FriendsLoaded(searchResults));
      } catch (e) {
        emit(FriendsError(e.toString()));
      }
    }
  }
}
