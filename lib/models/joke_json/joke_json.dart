import 'package:json_annotation/json_annotation.dart';

part 'joke_json.g.dart';

@JsonSerializable()
class JokeJson {
  final String id, value;
  JokeJson({required this.id, required this.value});

  factory JokeJson.fromJson(Map<String, dynamic> json) =>
      _$JokeJsonFromJson(json);

  Map<String, dynamic> toJson() => _$JokeJsonToJson(this);
}
