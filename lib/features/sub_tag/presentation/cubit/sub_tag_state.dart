import 'package:equatable/equatable.dart';
import '../../domain/entities/sub_tag.dart';

abstract class SubTagState extends Equatable {
  const SubTagState();

  @override
  List<Object?> get props => [];
}

class SubTagInitial extends SubTagState {}

class SubTagLoading extends SubTagState {}

class SubTagsLoaded extends SubTagState {
  final List<SubTag> subTags;

  const SubTagsLoaded({required this.subTags});

  @override
  List<Object?> get props => [subTags];
}

class SubTagError extends SubTagState {
  final String message;

  const SubTagError({required this.message});

  @override
  List<Object?> get props => [message];
}
