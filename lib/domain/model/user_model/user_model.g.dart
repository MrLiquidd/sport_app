// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      mobile: json['mobile'] as String,
      gender: json['gender'] as String,
      born_date: DateTime.parse(json['born_date'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'mobile': instance.mobile,
      'gender': instance.gender,
      'born_date': instance.born_date.toIso8601String(),
    };
