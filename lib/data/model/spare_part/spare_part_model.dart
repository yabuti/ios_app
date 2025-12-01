class SparePart {
  final String id;
  final String name;
  final double price;
  final String condition;
  final String category;
  final String compatible;
  final String image;

  SparePart({
    required this.id,
    required this.name,
    required this.price,
    required this.condition,
    required this.category,
    required this.compatible,
    required this.image,
  });

  factory SparePart.fromJson(Map<String, dynamic> json) {
    return SparePart(
      id: json['id'].toString(),
      name: json['name'],
      price: double.parse(json['price'].toString()),
      condition: json['condition'],
      category: json['category'],
      compatible: json['compatible'],
      image: json['image'],
    );
  }
}
