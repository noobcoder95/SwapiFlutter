class Starship {
  /// Using empty as default value for String and List rather than null
  /// to provide cleaner code
  Starship({
      this.url = '',
      this.name = '',
      this.model = '',
      this.manufacturer = '',
      this.costInCredits = '',
      this.hyperdriveRating = '',
      this.starshipClass = ''});

  factory Starship.fromJson(dynamic json) {
    return Starship(
        url: json['url'],
        name: json['name'] ?? '',
        model: json['model'] ?? '',
        manufacturer: json['manufacturer'] ?? '',
        costInCredits: json['cost_in_credits'] ?? '',
        hyperdriveRating: json['hyperdrive_rating'] ?? '',
        starshipClass: json['starship_class'] ?? '');
  }

  final String url;
  final String name;
  final String model;
  final String manufacturer;
  final String costInCredits;
  final String hyperdriveRating;
  final String starshipClass;

  Starship copyWith({
    String? url,
    String? name,
    String? model,
    String? manufacturer,
    String? costInCredits,
    String? hyperdriveRating,
    String? starshipClass
  }) => Starship(
    url: url ?? this.url,
    name: name ?? this.name,
    model: model ?? this.model,
    manufacturer: manufacturer ?? this.manufacturer,
    costInCredits: costInCredits ?? this.costInCredits,
    hyperdriveRating: hyperdriveRating ?? this.hyperdriveRating,
    starshipClass: starshipClass ?? this.starshipClass);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['name'] = name;
    map['model'] = model;
    map['manufacturer'] = manufacturer;
    map['cost_in_credits'] = costInCredits;
    map['hyperdrive_rating'] = hyperdriveRating;
    map['starship_class'] = starshipClass;
    return map;
  }
}