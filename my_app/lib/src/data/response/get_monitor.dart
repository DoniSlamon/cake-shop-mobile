class GetAllMonitor {
  final String name;
  final String category;
  final String brand;
  final int resolution; 
  final int refreshRate;
  final String srgb;
  final String price;

  GetAllMonitor({
    required this.name,
    required this.category,
    required this.brand,
    required this.resolution,
    required this.refreshRate,
    required this.srgb,
    required this.price,
  });

  factory GetAllMonitor.fromJson(Map<String, dynamic> json) {
    return GetAllMonitor(
      name: json['name'],
      category: json['category'],
      brand: json['brand'],
      resolution: json['resolution'],
      refreshRate: json['refresh_rate'],
      srgb: json['srgb'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'brand': brand,
      'resolution': resolution,
      'refresh_rate': refreshRate,
      'srgb': srgb,
      'price': price,
    };
  }
}
