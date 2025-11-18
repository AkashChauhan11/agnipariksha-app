import '../entities/tag.dart';
import '../repositories/tag_repository.dart';
import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class GetTags {
  final TagRepository repository;

  GetTags(this.repository);

  Future<Either<Failure, List<Tag>>> call({String? type, bool? isActive}) async {
    return await repository.getTags(type: type, isActive: isActive);
  }
}

