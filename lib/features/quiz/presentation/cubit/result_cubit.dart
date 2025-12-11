import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/result_data.dart';
import 'result_state.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit() : super(const ResultInitial());

  void loadResult(ResultData result) {
    emit(ResultLoaded(result));
  }
}

