import '../../domain/repositories/tag_repository.dart';
import '../../domain/entities/tag.dart';
import '../../domain/entities/sub_tag.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';
import 'package:dartz/dartz.dart';
import '../data_sources/tag_remote_data_source.dart';

class TagRepositoryImpl implements TagRepository {
  final TagRemoteDataSource remoteDataSource;

  TagRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Tag>>> getTags({String? type, bool? isActive}) async {
    try {
      final tags = await remoteDataSource.getTags(type: type, isActive: isActive);
      return Right(tags);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Tag>> getTagById(String id) async {
    try {
      final tag = await remoteDataSource.getTagById(id);
      return Right(tag);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<SubTag>>> getSubTags({String? tagId, String? type, bool? isActive}) async {
    try {
      final subTags = await remoteDataSource.getSubTags(tagId: tagId, type: type, isActive: isActive);
      return Right(subTags);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, SubTag>> getSubTagById(String id) async {
    try {
      final subTag = await remoteDataSource.getSubTagById(id);
      return Right(subTag);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}

