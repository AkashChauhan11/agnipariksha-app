import 'package:agni_pariksha/utils/typedef.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/state.dart' as LocationState;
import '../../domain/entities/city.dart';
import '../../domain/entities/country.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_remote_data_source.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;

  LocationRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<List<Country>> getCountries({bool? isActive}) async {
    try {
      final result = await remoteDataSource.getCountries(isActive: isActive);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred', 500));
    }
  }

  @override
  ResultFuture<List<LocationState.State>> getStatesByCountry({
    required String countryId,
    bool? isActive,
  }) async {
    try {
      final result = await remoteDataSource.getStatesByCountry(
        countryId: countryId,
        isActive: isActive,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred', 500));
    }
  }

  @override
  ResultFuture<List<City>> getCitiesByState({
    required String stateId,
    bool? isActive,
  }) async {
    try {
      final result = await remoteDataSource.getCitiesByState(
        stateId: stateId,
        isActive: isActive,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred', 500));
    }
  }
}

