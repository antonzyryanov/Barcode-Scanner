class ShopItem {
  final String imageUrl;
  final String name;
  final Map<String, int> sizesInStock;

  ShopItem({
    required this.imageUrl,
    required this.name,
    required this.sizesInStock,
  });

  factory ShopItem.fromJson(Map<String, dynamic> json) {
    return ShopItem(
      name: json['name'],
      imageUrl: json['imageUrl'],
      sizesInStock: Map<String, int>.from(json['sizesInStock']),
    );
  }
}
