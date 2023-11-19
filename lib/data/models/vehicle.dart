class Vehicle {
  /// Using empty as default value for String and List rather than null
  /// to provide cleaner code
  Vehicle({
      this.url = '',
      this.name = '',
      this.model = '',
      this.costInCredits = ''});

  factory Vehicle.fromJson(dynamic json) {
    return Vehicle(
        url: json['url'],
        name: json['name'] ?? '',
        model: json['model'] ?? '',
        costInCredits: json['cost_in_credits'] ?? '');
  }

  final String name;
  final String model;
  final String costInCredits;
  final String url;

  Vehicle copyWith({
    String? url,
    String? name,
    String? model,
    String? manufacturer,
    String? costInCredits
  }) => Vehicle(
    url: url ?? this.url,
    name: name ?? this.name,
    model: model ?? this.model,
    costInCredits: costInCredits ?? this.costInCredits);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['name'] = name;
    map['model'] = model;
    map['cost_in_credits'] = costInCredits;
    return map;
  }
}