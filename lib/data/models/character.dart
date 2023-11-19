import 'package:equatable/equatable.dart';
import 'package:swapi_flutter/utils/enums/gender.dart';
import 'package:swapi_flutter/utils/extension/gender.dart';

/// Extend equatable for unit testing purpose
class Character extends Equatable {
  /// Using empty as default value for String and List rather than null
  /// to provide cleaner code
  const Character({
      this.name = '',
      this.gender = '',
      this.homeworld = '',
      this.url = '',
      this.vehicles = const [],
      this.starships = const []});

  factory Character.fromJson(dynamic json) {
    return Character(
        name: json['name'] ?? '',
        gender: json['gender'] ?? '',
        homeworld: json['homeworld'] ?? '',
        url: json['url'] ?? '',
        vehicles: ((json['vehicles'] as List?) ?? []).map((e) => e.toString()).toList(),
        starships: ((json['starships'] as List?) ?? []).map((e) => e.toString()).toList());
  }

  final String name;
  final String gender;
  final String homeworld;
  final String url;
  final List<String> vehicles;
  final List<String> starships;

  /// Parsing gender string to enum to provide cleaner code for filter purpose
  Gender get genderEnum => Gender.values.firstWhere((e)=> e.label == gender, orElse: ()=> Gender.unknown);

  Character copyWith({
    String? name,
    String? gender,
    String? homeworld,
    String? url,
    List<String>? vehicles,
    List<String>? starships}) => Character(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      homeworld: homeworld ?? this.homeworld,
      url: url ?? this.url,
      vehicles: vehicles ?? this.vehicles,
      starships: starships ?? this.starships);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['gender'] = gender;
    map['homeworld'] = homeworld;
    map['url'] = url;
    map['vehicles'] = vehicles;
    map['starships'] = starships;
    return map;
  }

  @override
  List<Object> get props => [
  name,
  gender,
  homeworld,
  url,
  vehicles,
  starships];
}