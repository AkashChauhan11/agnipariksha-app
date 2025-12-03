import 'package:agni_pariksha/core/usecase/usecase.dart';
import 'package:agni_pariksha/features/sub_tag/domain/repositories/sub_tag_repository.dart';
import 'package:agni_pariksha/utils/typedef.dart';
import 'package:equatable/equatable.dart';
import '../entities/sub_tag.dart';

class GetSubTagsByTagIdUsecase
    extends UsecaseWithParams<List<SubTag>, GetSubTagsByTagIdParams> {
  const GetSubTagsByTagIdUsecase(this._repository);

  final SubTagRepository _repository;

  @override
  ResultFuture<List<SubTag>> call(GetSubTagsByTagIdParams params) async =>
      _repository.getSubTagsByTagId(params.tagId);
}

class GetSubTagsByTagIdParams extends Equatable {
  final String tagId;

  const GetSubTagsByTagIdParams({required this.tagId});

  @override
  List<Object?> get props => [tagId];
}
