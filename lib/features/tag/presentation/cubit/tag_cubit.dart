import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_tags.dart';
import '../../domain/usecases/get_sub_tags.dart';
import '../../../../core/errors/failures.dart';
import 'tag_state.dart';

class TagCubit extends Cubit<TagState> {
  final GetTags getTags;
  final GetSubTags getSubTags;

  TagCubit({
    required this.getTags,
    required this.getSubTags,
  }) : super(TagInitial());

  Future<void> fetchMainTags() async {
    emit(TagLoading());
    final result = await getTags(type: 'main', isActive: true);
    result.fold(
      (failure) => emit(TagError(_mapFailureToMessage(failure))),
      (tags) => emit(TagLoaded(tags)),
    );
  }

  Future<void> fetchSubjectTags() async {
    emit(TagLoading());
    final result = await getTags(type: 'subject', isActive: true);
    result.fold(
      (failure) => emit(TagError(_mapFailureToMessage(failure))),
      (tags) => emit(TagLoaded(tags)),
    );
  }

  Future<void> fetchAllTags() async {
    emit(TagLoading());
    final result = await getTags(isActive: true);
    result.fold(
      (failure) => emit(TagError(_mapFailureToMessage(failure))),
      (tags) => emit(TagLoaded(tags)),
    );
  }

  Future<void> fetchSubTagsByTagId(String tagId) async {
    emit(SubTagLoading());
    final result = await getSubTags(tagId: tagId, isActive: true);
    result.fold(
      (failure) => emit(SubTagError(_mapFailureToMessage(failure))),
      (subTags) => emit(SubTagLoaded(subTags)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is NetworkFailure) {
      return failure.message;
    } else {
      return 'Unexpected error occurred';
    }
  }
}

