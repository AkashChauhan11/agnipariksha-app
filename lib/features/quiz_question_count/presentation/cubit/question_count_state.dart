import 'package:equatable/equatable.dart';

abstract class QuestionCountState extends Equatable {
  const QuestionCountState();

  @override
  List<Object?> get props => [];
}

class QuestionCountInitial extends QuestionCountState {
  const QuestionCountInitial();
}

class QuestionCountLoading extends QuestionCountState {
  const QuestionCountLoading();
}

class QuestionCountError extends QuestionCountState {
  final String message;

  const QuestionCountError(this.message);

  @override
  List<Object?> get props => [message];
}

class QuestionCountLoaded extends QuestionCountState {
  final List<int> questionOptions;
  final int? selectedCount;
  final bool considerTime;

  const QuestionCountLoaded({
    required this.questionOptions,
    this.selectedCount,
    this.considerTime = false,
  });

  QuestionCountLoaded copyWith({
    List<int>? questionOptions,
    int? selectedCount,
    bool? considerTime,
  }) {
    return QuestionCountLoaded(
      questionOptions: questionOptions ?? this.questionOptions,
      selectedCount: selectedCount ?? this.selectedCount,
      considerTime: considerTime ?? this.considerTime,
    );
  }

  @override
  List<Object?> get props => [questionOptions, selectedCount, considerTime];
}

