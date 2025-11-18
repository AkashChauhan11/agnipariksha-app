import '../entities/tag.dart';
import '../entities/sub_tag.dart';
import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class TagRepository {
  Future<Either<Failure, List<Tag>>> getTags({String? type, bool? isActive});
  Future<Either<Failure, Tag>> getTagById(String id);
  Future<Either<Failure, List<SubTag>>> getSubTags({String? tagId, String? type, bool? isActive});
  Future<Either<Failure, SubTag>> getSubTagById(String id);
}

