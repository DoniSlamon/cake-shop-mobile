class Cake {
  final int id;
  final String name;
  final String category;
  final String flavor;
  final String size;
  final int weight; // in grams
  final String description;
  final int price;
  final String imagePath;
  final bool isAvailable;
  final double rating;

  Cake({
    required this.id,
    required this.name,
    required this.category,
    required this.flavor,
    required this.size,
    required this.weight,
    required this.description,
    required this.price,
    required this.imagePath,
    this.isAvailable = true,
    this.rating = 0.0,
  });

  factory Cake.fromJson(Map<String, dynamic> json) {
    return Cake(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      flavor: json['flavor'],
      size: json['size'],
      weight: json['weight'],
      description: json['description'] ?? '',
      price: json['price'],
      imagePath: json['image_path'],
      isAvailable: json['is_available'] ?? true,
      rating: (json['rating'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'flavor': flavor,
      'size': size,
      'weight': weight,
      'description': description,
      'price': price,
      'image_path': imagePath,
      'is_available': isAvailable,
      'rating': rating,
    };
  }
}
