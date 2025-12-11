import 'package:agni_pariksha/utils/typedef.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/question_count_repository.dart';
import '../datasources/question_count_remote_data_source.dart';

class QuestionCountRepositoryImpl implements QuestionCountRepository {
  final QuestionCountRemoteDataSource remoteDataSource;

  QuestionCountRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<bool> validateSubject(String subjectId) async {
    try {
      final result = await remoteDataSource.validateSubject(subjectId);
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
  ResultFuture<void> startQuiz({
    required String subjectId,
    required int questionCount,
    required bool considerTime,
  }) async {
    try {
      await remoteDataSource.startQuiz(
        subjectId: subjectId,
        questionCount: questionCount,
        considerTime: considerTime,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred', 500));
    }
  }
}

