import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class User {
  final String login;
  final String? name;
  final String? avatarUrl;
  final String? reposUrl;

  User({required this.login, this.name, this.avatarUrl, this.reposUrl});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
