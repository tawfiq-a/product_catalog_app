class ProductModel {
  final String id;
  final String name;
  final String? description;

  ProductModel({required this.id, required this.name, this.description});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id']?.toString() ?? '',
    name: json['name'] ?? '',
    description: json['description'],
  );
}
