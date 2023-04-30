part 'auth_header.g.dart';

class AuthHeader {
  String? deviceId;
  String? token;
  String? deviceType;
  double? lat;
  double? long;

  AuthHeader({
    this.deviceId,
    this.token,
    this.deviceType,
    this.lat,
    this.long,
  });

  factory AuthHeader.fromJson(Map<String, dynamic> json) =>
      _$AuthHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$AuthHeaderToJson(this);
}
