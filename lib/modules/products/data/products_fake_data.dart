import '../models/product.dart';

class FakeProductsData {
  FakeProductsData._();

  static const String defaultUserName = 'Ahmed';
  static const String defaultUserAvatarUrl =
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300&q=80';

  static const List<String> topBannerImages = [
    'https://images.unsplash.com/photo-1507842229356-51c61504d3ab?w=800&q=80',
    'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=800&q=80',
    'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=800&q=80',
  ];

  static const List<String> promoBannerImages = [
    'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=800&q=80',
    'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=800&q=80',
    'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=800&q=80',
  ];

  static const List<BookCategoryModel> bookCategories = [
    BookCategoryModel(
      id: '1',
      name: 'Software',
      imageUrl: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=400&q=80',
    ),
    BookCategoryModel(
      id: '2',
      name: 'DevOps',
      imageUrl: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=400&q=80',
    ),
    BookCategoryModel(
      id: '3',
      name: 'AI & Data Science',
      imageUrl: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=400&q=80',
    ),
    BookCategoryModel(
      id: '4',
      name: 'Cyber Security',
      imageUrl: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=400&q=80',
    ),
  ];

  static const List<Product> bestSellerBooks = [
    Product(
      name: 'Clean Architecture',
      originalPrice: 289.00,
      discountedPrice: 173.4,
      discountPercentage: 40,
      description: 'A Craftsman\'s Guide to Software Structure and Design.',
      category: 'Software',
      imageUrl: 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=500&q=80',
    ),
    Product(
      name: 'Algorithms Unplugged',
      originalPrice: 279.00,
      discountedPrice: 195.3,
      discountPercentage: 30,
      description: 'Real-world algorithms explained cleanly and intuitively.',
      category: 'Software',
      imageUrl: 'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=500&q=80',
    ),
    Product(
      name: 'Data Science from Scratch.2',
      originalPrice: 279.00,
      discountedPrice: 139.5,
      discountPercentage: 50,
      description: 'First Principles with Python for modern data science.',
      category: 'AI & Data Science',
      imageUrl: 'https://images.unsplash.com/photo-1589998059171-988d887df646?w=500&q=80',
    ),
    Product(
      name: 'Refactoring UI',
      originalPrice: 320.00,
      discountedPrice: 224.0,
      discountPercentage: 30,
      description: 'Make your ideas look awesome, without relying on a designer.',
      category: 'Software',
      imageUrl: 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=500&q=80',
    ),
  ];

  static const List<Product> newArrivalBooks = [
    Product(
      name: 'Mathematics for Machine Learning',
      originalPrice: 279.00,
      discountedPrice: 167.4,
      discountPercentage: 40,
      description: 'Fundamental mathematical tools needed to understand machine learning.',
      category: 'AI & Data Science',
      imageUrl: 'https://images.unsplash.com/photo-1509228468518-180dd4864904?w=500&q=80',
    ),
    Product(
      name: 'Hands-On Machine Learning',
      originalPrice: 489.00,
      discountedPrice: 317.85,
      discountPercentage: 35,
      description: 'Concepts, Tools, and Techniques to Build Intelligent Systems.',
      category: 'AI & Data Science',
      imageUrl: 'https://images.unsplash.com/photo-1515879218367-8466d910aaa4?w=500&q=80',
    ),
    Product(
      name: 'Data Science from Scratch.2',
      originalPrice: 279.00,
      discountedPrice: 139.5,
      discountPercentage: 50,
      description: 'First Principles with Python for modern data science.',
      category: 'AI & Data Science',
      imageUrl: 'https://images.unsplash.com/photo-1589998059171-988d887df646?w=500&q=80',
    ),
    Product(
      name: 'Docker Deep Dive',
      originalPrice: 250.00,
      discountedPrice: 175.0,
      discountPercentage: 30,
      description: 'Zero to Docker in a single book.',
      category: 'DevOps',
      imageUrl: 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=500&q=80',
    ),
  ];
}
