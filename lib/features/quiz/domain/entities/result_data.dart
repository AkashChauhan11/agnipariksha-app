import 'package:equatable/equatable.dart';

class ResultData extends Equatable {
  final int correct;
  final int wrong;
  final int skipped;
  final Duration totalTime;
  final Duration avgTime;

  const ResultData({
    required this.correct,
    required this.wrong,
    required this.skipped,
    required this.totalTime,
    required this.avgTime,
  });

  int get total => correct + wrong + skipped;

  @override
  List<Object?> get props => [correct, wrong, skipped, totalTime, avgTime];
}

