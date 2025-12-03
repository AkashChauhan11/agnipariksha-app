import 'package:agni_pariksha/utils/typedef.dart';
import '../entities/sub_tag.dart';

abstract class SubTagRepository {
  ResultFuture<List<SubTag>> getSubTagsByTagId(String tagId);
}
