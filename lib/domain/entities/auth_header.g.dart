// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthHeader _$AuthHeaderFromJson(Map<String, dynamic> json) => AuthHeader(
      deviceId: json['deviceId'] as String?,
      token: json['token'] as String?,
      deviceType: json['deviceType'] as String?,
      lat: (json['latitude'] as num?)?.toDouble(),
      long: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AuthHeaderToJson(AuthHeader instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'token': instance.token,
      'deviceType': instance.deviceType,
      'latitude': instance.lat,
      'longitude': instance.long,
    };
