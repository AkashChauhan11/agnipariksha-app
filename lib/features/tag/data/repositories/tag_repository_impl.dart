import 'package:agni_pariksha/utils/typedef.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/tag.dart';
import '../../domain/repositories/tag_repository.dart';
import '../datasources/tag_remote_data_source.dart';

class TagRepositoryImpl implements TagRepository {
  final TagRemoteDataSource remoteDataSource;

  TagRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<List<Tag>> getTagsByType(TagType type, {bool? isActive}) async {
    try {
      final result = await remoteDataSource.getTagsByType(
        type,
        isActive: isActive,
      );
      return Right(result);
    } on ServerException catch (e) {
      print("error in repository: ${e.toString()}");
      return Left(ServerFailure(e.message, e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred', 500));
    }
  }
}

