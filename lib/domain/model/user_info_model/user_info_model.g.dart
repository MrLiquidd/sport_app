// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
        id: json['id'] as String,
        first_name: json['first_name'] as String,
        last_name: json['last_name'] as String,
        about_me: json['about_me'] as String,
        age: json['age'] as int,
        deleted: json['deleted'] as bool,
        photo_id: json['photo_id'] as String,
        city: json['city'] as String,
        friends_count: json['friends_count'] as int,
        visits_count: json['visits_count'] as int);

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'about_me': instance.about_me,
      'age': instance.age,
      'deleted': instance.deleted,
      'photo_id': instance.photo_id,
      'city': instance.city,
      'friends_count': instance.friends_count,
      'visits_count': instance.friends_count,
    };
