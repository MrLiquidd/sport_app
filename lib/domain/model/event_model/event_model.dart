import 'package:json_annotation/json_annotation.dart';
import 'event_date_parser.dart';

part 'event_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Event{
  final String id;
  final String title;
  final int price;
  final String about;
  final int minAge;
  final int quantity;
  final String photoId;
  final DateTime date;
  final bool isActive;
  final DateTime createDate;
  final bool archive;
  final bool deleted;
  final String eventType;
  final String full_addresses;
  final int user_count;

  Event({
    required this.id,
    required this.title,
    required this.price,
    required this.about,
    required this.minAge,
    required this.quantity,
    required this.photoId,
    required this.date,
    required this.isActive,
    required this.createDate,
    required this.archive,
    required this.deleted,
    required this.eventType,
    required this.full_addresses,
    required this.user_count,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

}