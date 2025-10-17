import '../models/dashboard_model.dart';

class DashboardRemoteDataSource {
  Future<DashboardModel> fetchDashboardData() async {
    await Future.delayed(const Duration(seconds: 2));
    return DashboardModel(
      banners: [
        'assets/images/caurosel_1.jpeg',
        'assets/images/caurosel_2.jpeg',
        'assets/images/caurosel_3.jpg',
      ],
      categories: [
        CategoryModel(name: 'Science', imageUrl: 'assets/images/ncert.png'),
        CategoryModel(name: 'Math', imageUrl: 'assets/images/gcert.jpeg'),
        CategoryModel(name: 'History', imageUrl: 'assets/images/history.png'),
        CategoryModel(name: 'Sports', imageUrl: 'assets/images/constitution.jpg'),
        CategoryModel(name: 'Physics', imageUrl: 'assets/images/ncert.png'),
        CategoryModel(name: 'Chemistry', imageUrl: 'assets/images/gcert.jpeg'),
        CategoryModel(name: 'Geography', imageUrl: 'assets/images/history.png'),
        CategoryModel(name: 'Literature', imageUrl: 'assets/images/constitution.jpg'),
        CategoryModel(name: 'Computer', imageUrl: 'assets/images/ncert.png'),
      ],
    );
  }
} 