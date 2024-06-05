import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class UserModel {
  final String id;
  final String email;
  final String username;
  final String mobile;
  final String gender;
  final DateTime born_date;

  UserModel({required this.id,
    required this.email,
    required this.username,
    required this.mobile,
    required this.gender,
    required this.born_date
  });


  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}