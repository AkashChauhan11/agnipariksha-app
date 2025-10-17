import '../../domain/entities/dashboard.dart';

class DashboardModel {
  final List<String> banners;
  final List<CategoryModel> categories;

  DashboardModel({required this.banners, required this.categories});

  factory DashboardModel.fromEntity(Dashboard dashboard) {
    return DashboardModel(
      banners: dashboard.banners,
      categories: dashboard.categories.map((e) => CategoryModel.fromEntity(e)).toList(),
    );
  }

  Dashboard toEntity() {
    return Dashboard(
      banners: banners,
      categories: categories.map((e) => e.toEntity()).toList(),
    );
  }
}

class CategoryModel {
  final String name;
  final String imageUrl;

  CategoryModel({required this.name, required this.imageUrl});

  factory CategoryModel.fromEntity(Category category) {
    return CategoryModel(name: category.name, imageUrl: category.imageUrl);
  }

  Category toEntity() {
    return Category(name: name, imageUrl: imageUrl);
  }
} 