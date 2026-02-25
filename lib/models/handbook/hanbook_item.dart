class HanbookItem {
  final int id;
  final String title;
  final String description;

  HanbookItem({
    required this.id,
    required this.title,
    required this.description,
  });

  factory HanbookItem.fromJson(Map<String, dynamic> json) {
    return HanbookItem(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}
