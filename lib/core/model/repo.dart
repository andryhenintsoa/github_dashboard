import 'package:json_annotation/json_annotation.dart';

part 'repo.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Repo {
  final String name;
  final String? language;
  final String? description;
  final String htmlUrl;

  Repo({required this.name, this.language, this.description, required this.htmlUrl});

  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);

  Map<String, dynamic> toJson() => _$RepoToJson(this);
}
