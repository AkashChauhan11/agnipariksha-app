import '../../domain/entities/dashboard.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../models/dashboard_model.dart';
import '../data_sources/dashboard_remote_data_source.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  DashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Dashboard> fetchDashboardData() async {
    final model = await remoteDataSource.fetchDashboardData();
    return model.toEntity();
  }
} 