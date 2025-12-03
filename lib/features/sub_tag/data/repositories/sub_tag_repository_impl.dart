import 'package:agni_pariksha/utils/typedef.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/sub_tag.dart';
import '../../domain/repositories/sub_tag_repository.dart';
import '../datasources/sub_tag_remote_data_source.dart';

class SubTagRepositoryImpl implements SubTagRepository {
  final SubTagRemoteDataSource remoteDataSource;

  SubTagRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<List<SubTag>> getSubTagsByTagId(String tagId) async {
    try {
      final result = await remoteDataSource.getSubTagsByTagId(tagId);
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
