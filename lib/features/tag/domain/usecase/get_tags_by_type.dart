import 'package:agni_pariksha/core/usecase/usecase.dart';
import 'package:agni_pariksha/features/tag/domain/repositories/tag_repository.dart';
import 'package:agni_pariksha/utils/typedef.dart';
import 'package:equatable/equatable.dart';
import '../entities/tag.dart';

class GetTagsByTypeUsecase extends UsecaseWithParams<List<Tag>, GetTagsByTypeParams> {
  const GetTagsByTypeUsecase(this._repository);

  final TagRepository _repository;

  @override
  ResultFuture<List<Tag>> call(GetTagsByTypeParams params) async =>
      _repository.getTagsByType(
        params.type,
        isActive: params.isActive,
      );
}

class GetTagsByTypeParams extends Equatable {
  final TagType type;
  final bool? isActive;

  const GetTagsByTypeParams({
    required this.type,
    this.isActive,
  });

  @override
  List<Object?> get props => [type, isActive];
}

