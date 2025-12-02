import 'package:agni_pariksha/utils/typedef.dart';
import '../entities/tag.dart';

abstract class TagRepository {
  ResultFuture<List<Tag>> getTagsByType(TagType type, {bool? isActive});
}

