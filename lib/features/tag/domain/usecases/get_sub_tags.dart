import '../entities/sub_tag.dart';
import '../repositories/tag_repository.dart';
import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class GetSubTags {
  final TagRepository repository;

  GetSubTags(this.repository);

  Future<Either<Failure, List<SubTag>>> call({String? tagId, String? type, bool? isActive}) async {
    return await repository.getSubTags(tagId: tagId, type: type, isActive: isActive);
  }
}

