class RatingModel {
  final double rate;
  final int count;

  RatingModel({
    required this.rate,
    required this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
        count: json['count'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'rate': rate,
        'count': count,
      };
}

class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingModel rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as int? ?? 0,
        title: json['title'] ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        description: json['description'] ?? '',
        category: json['category'] ?? '',
        image: json['image'] ?? '',
        rating: RatingModel.fromJson(json['rating'] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': rating.toJson(),
      };
}
