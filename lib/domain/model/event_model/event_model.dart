
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class EventModel{
  final String id;
  final String title;
  final String about;
  final int min_age;
  final int quantity;
  final String photo_id;
  @JsonKey(fromJson: parseMovieDateFromString)
  final DateTime? releaseDate;
  String location;

  EventModel({

})
}