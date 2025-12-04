import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_sub_tags_by_tag_id.dart';
import 'sub_tag_state.dart';

class SubTagCubit extends Cubit<SubTagState> {
  final GetSubTagsByTagIdUsecase getSubTagsByTagIdUsecase;

  SubTagCubit({required this.getSubTagsByTagIdUsecase})
    : super(SubTagInitial());

  Future<void> loadSubTagsByTagId(String tagId) async {
    print("loadSubTagsByTagId: $tagId");
    emit(SubTagLoading());

    final result = await getSubTagsByTagIdUsecase(
      GetSubTagsByTagIdParams(tagId: tagId),
    );
    print("result: $result");

    result.fold(
      (failure) => emit(SubTagError(message: failure.message)),
      (subTags) => emit(
        SubTagsLoaded(
          subTags: subTags..sort((a, b) => a.order.compareTo(b.order)),
        ),
      ),
    );
  }
}
