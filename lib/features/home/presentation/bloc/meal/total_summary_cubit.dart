import 'package:calorify/features/home/domain/usecases/meal/get_total_day_summary.dart';
import 'package:calorify/features/home/presentation/bloc/meal/total_summary_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TotalSummaryCubit extends Cubit<TotalSummaryState>{
  final GetTotalDaySummary getTotalDaySummary;

  TotalSummaryCubit({required this.getTotalDaySummary}) : super(TotalSummaryInitial());

  Future<void> loadTotal() async{
    emit(TotalSummaryLoading());
    try{
      final dateKey = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final total = await getTotalDaySummary.call(dateKey);
      emit(TotalSummaryLoaded(total: total));

    }catch(e){
      emit(TotalSummaryError(message: 'Failed to load users: $e'));
    }
  }
}
