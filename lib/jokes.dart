import 'package:json_annotation/json_annotation.dart';

part 'jokes.g.dart';

@JsonSerializable()
class Jokes {
  @JsonKey(name: 'created_at')
  String? creationDate;
  @JsonKey(name: 'icon_url')
  String? iconUrl;
  String? id;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  String? url;
  String? value;

  Jokes([value, iconUrl]);

  factory Jokes.fromJson(Map<String, dynamic> json) => $JokeFromJson(json);
  Map<String, dynamic> toJson() => $JokeToJson(this);

  @override
  String toString() {
    return 'value: ${value!}';
  }
}
