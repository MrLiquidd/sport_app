import 'package:json_annotation/json_annotation.dart';

part 'user_info_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class UserInfoModel {
  final String id;
  final String first_name;
  final String last_name;
  final String about_me;
  final int age;
  final bool deleted;
  final String photo_id;
  final String city;
  final int friends_count;

  UserInfoModel({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.about_me,
    required this.age,
    required this.deleted,
    required this.photo_id,
    required this.city,
    required this.friends_count,
  });


  factory UserInfoModel.fromJson(Map<String, dynamic> json) => _$UserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}