import 'package:equatable/equatable.dart';

import 'character.dart';

/// Extend equatable for unit testing purpose
class CharacterList extends Equatable {
  /// Using empty as default value for String and List rather than null
  /// to provide cleaner code
  const CharacterList({
    this.count = 0, /// Considering this value is use to count the length of Results, i'm using zero as default value rather than null
    this.next = '',
    this.previous = '',
    this.results = const []});

  factory CharacterList.fromJson(dynamic json) {
    return CharacterList(
        count: json['count'] ?? 0,
        next: json['next'] ?? '',
        previous: json['previous'] ?? '',
        results: ((json['results'] as List?) ?? [])
            .map((e) => Character.fromJson(e)).toList()
    );
  }

  final num count;
  final String next;
  final String previous;
  final List<Character> results;

  CharacterList copyWith({
    num? count,
    String? next,
    String? previous,
    List<Character>? results,
  }) => CharacterList(
    count: count ?? this.count,
    next: next ?? this.next,
    previous: previous ?? this.previous,
    results: results ?? this.results);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['next'] = next;
    map['previous'] = previous;
    map['results'] = results.map((v) => v.toJson()).toList();
    return map;
  }

  @override
  List<Object> get props => [
    count,
    next,
    previous,
    results
  ];
}