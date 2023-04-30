import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

class ApiResponse {

  final String? code;
  final String? message;
  final dynamic payload;


  ApiResponse(
      { this.code, this.message, this.payload});

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}

