import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_tags_by_type.dart';
import '../../domain/entities/tag.dart';
import 'tag_state.dart';

class TagCubit extends Cubit<TagState> {
  final GetTagsByTypeUsecase getTagsByTypeUsecase;

  TagCubit({
    required this.getTagsByTypeUsecase,
  }) : super(TagInitial());

  Future<void> loadTagsByType(TagType type, {bool? isActive}) async {
    emit(TagLoading());

    final result = await getTagsByTypeUsecase(
      GetTagsByTypeParams(type: type, isActive: isActive),
    );

    result.fold(
      (failure) => emit(TagError(message: failure.message)),
      (tags) => emit(TagsLoaded(tags: tags)),
    );
  }
}

