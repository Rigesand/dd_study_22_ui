// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      about: json['about'] as String,
      birthDate: json['birthDate'] as String,
      avatarLink: json['avatarLink'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'about': instance.about,
      'birthDate': instance.birthDate,
      'avatarLink': instance.avatarLink,
    };
