// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repo _$RepoFromJson(Map<String, dynamic> json) {
  return Repo(
    name: json['name'] as String,
    language: json['language'] as String?,
    description: json['description'] as String?,
    htmlUrl: json['html_url'] as String,
  );
}

Map<String, dynamic> _$RepoToJson(Repo instance) => <String, dynamic>{
      'name': instance.name,
      'language': instance.language,
      'description': instance.description,
      'html_url': instance.htmlUrl,
    };
