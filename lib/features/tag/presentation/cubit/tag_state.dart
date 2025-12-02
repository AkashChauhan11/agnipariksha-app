import 'package:equatable/equatable.dart';
import '../../domain/entities/tag.dart';

abstract class TagState extends Equatable {
  const TagState();

  @override
  List<Object?> get props => [];
}

class TagInitial extends TagState {}

class TagLoading extends TagState {}

class TagsLoaded extends TagState {
  final List<Tag> tags;

  const TagsLoaded({required this.tags});

  @override
  List<Object?> get props => [tags];
}

class TagError extends TagState {
  final String message;

  const TagError({required this.message});

  @override
  List<Object?> get props => [message];
}

