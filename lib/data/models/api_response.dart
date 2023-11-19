class ApiResponse {
  const ApiResponse({this.message = '', this.data});

  factory ApiResponse.fromJson(dynamic json) =>
      ApiResponse(
        message: json['message'] ?? '',
        data: json['data']);

  final String message;
  final dynamic data;

  ApiResponse copyWith({
    String? message,
    dynamic data,
  }) => ApiResponse(
      message: message ?? this.message,
      data: data ?? this.data);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['data'] = data;
    return map;
  }
}