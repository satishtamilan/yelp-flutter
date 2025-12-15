class Business {
  final String id;
  final String name;
  final double rating;
  final String price;
  final String category;
  final String address;
  final String aiTip;
  final String? imageUrl;

  Business({
    required this.id,
    required this.name,
    required this.rating,
    required this.price,
    required this.category,
    required this.address,
    required this.aiTip,
    this.imageUrl,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      rating: (json['rating'] ?? 0.0).toDouble(),
      price: json['price'] ?? '££',
      category: json['categories']?[0]?['title'] ?? 'Restaurant',
      address: json['location']?['formatted_address'] ?? '',
      aiTip: json['summaries']?['short'] ?? 'Great local spot!',
      imageUrl: json['contextual_info']?['photos']?[0]?['original_url'],
    );
  }
}

class YelpResponse {
  final String text;
  final List<Business> businesses;

  YelpResponse({
    required this.text,
    required this.businesses,
  });
}


