class HomeWorld {
  /// Using empty as default value for String rather than null
  /// to provide cleaner code
  const HomeWorld({
      this.url = '',
      this.name = '',
      this.climate = '',
      this.population = ''});

  factory HomeWorld.fromJson(dynamic json) {
    return HomeWorld(
        url: json['url'],
        name: json['name'],
        climate: json['climate'],
        population: json['population']);
  }

  final String url;
  final String name;
  final String climate;
  final String population;

  HomeWorld copyWith({
    String? url,
    String? name,
    String? climate,
    String? population
  }) => HomeWorld(
      url: url ?? this.url,
      name: name ?? this.name,
      climate: climate ?? this.climate,
      population: population ?? this.population);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['name'] = name;
    map['climate'] = climate;
    map['population'] = population;
    return map;
  }
}