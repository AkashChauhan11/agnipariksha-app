import 'package:equatable/equatable.dart';
import '../../domain/entities/result_data.dart';

abstract class ResultState extends Equatable {
  const ResultState();

  @override
  List<Object?> get props => [];
}

class ResultInitial extends ResultState {
  const ResultInitial();
}

class ResultLoaded extends ResultState {
  final ResultData result;

  const ResultLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

