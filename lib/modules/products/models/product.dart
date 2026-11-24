class Product {
  final int? id;
  final String name;
  final double originalPrice;
  final double discountedPrice;
  final int discountPercentage;
  final String description;
  final String category;
  final String imageUrl;
  final int? stock;
  final int? bestSeller;

  const Product({
    this.id,
    required this.name,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercentage,
    required this.description,
    required this.category,
    required this.imageUrl,
    this.stock,
    this.bestSeller,
  });
}

class BookCategoryModel {
  final String id;
  final String name;
  final String imageUrl;
  final int? productsCount;

  const BookCategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.productsCount,
  });
}
