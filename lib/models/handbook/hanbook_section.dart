import 'hanbook_item.dart';

class HanbookSection {
  final int id;
  final String name;
  final List<HanbookItem> items;

  HanbookSection({required this.id, required this.name, required this.items});

  factory HanbookSection.fromJson(Map<String, dynamic> json) {
    return HanbookSection(
      id: json['id'] as int,
      name: json['name'] as String,
      items: (json['items'] as List)
          .map((item) => HanbookItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
