import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/dashboard.dart';
import '../../domain/usecases/get_dashboard_data.dart';

// Events
abstract class DashboardEvent {}
class FetchDashboardData extends DashboardEvent {}
class ChangeDashboardPage extends DashboardEvent {
  final int pageIndex;
  ChangeDashboardPage(this.pageIndex);
}

// States
abstract class DashboardState {}
class DashboardInitial extends DashboardState {}
class DashboardLoading extends DashboardState {}
class DashboardLoaded extends DashboardState {
  final Dashboard dashboard;
  final int currentPageIndex;
  DashboardLoaded(this.dashboard, {this.currentPageIndex = 0});
}
class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}

// Bloc
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardData getDashboardData;
  Dashboard? _dashboard;
  int _currentPageIndex = 0;

  DashboardBloc(this.getDashboardData) : super(DashboardInitial()) {
    on<FetchDashboardData>((event, emit) async {
      emit(DashboardLoading());
      try {
        final dashboard = await getDashboardData();
        _dashboard = dashboard;
        emit(DashboardLoaded(dashboard, currentPageIndex: _currentPageIndex));
      } catch (e) {
        emit(DashboardError('Failed to load dashboard'));
      }
    });
    on<ChangeDashboardPage>((event, emit) {
      _currentPageIndex = event.pageIndex;
      if (_dashboard != null) {
        emit(DashboardLoaded(_dashboard!, currentPageIndex: _currentPageIndex));
      }
    });
  }
} 