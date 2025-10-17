class Dashboard {
  final List<String> banners;
  final List<Category> categories;

  Dashboard({required this.banners, required this.categories});
}

class Category {
  final String name;
  final String imageUrl;

  Category({required this.name, required this.imageUrl});
} 