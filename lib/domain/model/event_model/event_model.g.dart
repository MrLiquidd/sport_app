// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as String,
      title: json['title'] as String,
      price: json['price'] as int,
      about: json['about'] as String,
      minAge: json['min_age'] as int,
      quantity: json['quantity'] as int,
      photoId: json['photo_id'] as String,
      date: DateTime.parse(json['date'] as String),
      isActive: json['is_active'] as bool,
      createDate: DateTime.parse(json['create_date'] as String),
      archive: json['archive'] as bool,
      deleted: json['deleted'] as bool,
      eventType: json['event_type'] as String,
      full_addresses: json['full_addresses'] as String,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'about': instance.about,
      'min_age': instance.minAge,
      'quantity': instance.quantity,
      'photo_id': instance.photoId,
      'date': instance.date.toIso8601String(),
      'is_active': instance.isActive,
      'create_date': instance.createDate.toIso8601String(),
      'archive': instance.archive,
      'deleted': instance.deleted,
      'event_type': instance.eventType,
      'full_addresses': instance.full_addresses
    };
