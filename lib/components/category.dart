import 'dart:convert';

class Category {
  int id;
  String name;

  Category({
    required this.id,
    required this.name,
  });

  Category.fromJson(Map json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});

    return result;
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
}
