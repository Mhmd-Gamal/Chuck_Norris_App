part of 'jokes.dart';

Jokes $JokeFromJson(Map<String, dynamic> json) => Jokes(
      json['value'],
      json['icon_url'],
    )
      ..creationDate = json['creation_date'] as String?
      ..url = json['url'] as String?
      ..updatedAt = json['updated_at'] as String?
      ..id = json['id'] as String?
      ..value = json['value'] as String?
      ..iconUrl = json['icon_url'] as String?;

Map<String, dynamic> $JokeToJson(Jokes instance) => <String, dynamic>{
      'creation_date': instance.creationDate,
      'icon_url': instance.iconUrl,
      'value': instance.value,
      'url': instance.url,
      'updated_at': instance.updatedAt,
      'id': instance.id,
    };
