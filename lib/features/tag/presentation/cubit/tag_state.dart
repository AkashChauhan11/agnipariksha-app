import '../../domain/entities/tag.dart';
import '../../domain/entities/sub_tag.dart';

abstract class TagState {}

class TagInitial extends TagState {}

class TagLoading extends TagState {}

class TagLoaded extends TagState {
  final List<Tag> tags;

  TagLoaded(this.tags);
}

class TagError extends TagState {
  final String message;

  TagError(this.message);
}

class SubTagLoading extends TagState {}

class SubTagLoaded extends TagState {
  final List<SubTag> subTags;

  SubTagLoaded(this.subTags);
}

class SubTagError extends TagState {
  final String message;

  SubTagError(this.message);
}

