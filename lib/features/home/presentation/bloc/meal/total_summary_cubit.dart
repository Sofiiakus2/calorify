import 'package:calorify/features/home/domain/usecases/meal/get_total_day_summary.dart';
import 'package:calorify/features/home/presentation/bloc/meal/total_summary_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TotalSummaryCubit extends Cubit<TotalSummaryState>{
  final GetTotalDaySummary getTotalDaySummary;
  Map<String, double>? _cachedTotal;

  TotalSummaryCubit({required this.getTotalDaySummary}) : super(TotalSummaryInitial());

  Future<void> loadTotal() async {
    try {
      final dateKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final total = await getTotalDaySummary.call(dateKey);

      if (_cachedTotal == null || !_mapEquals(_cachedTotal!, total)) {
        _cachedTotal = total;

        emit(TotalSummaryLoaded(total: total));
      }
    } catch (e) {
      emit(TotalSummaryError(message: 'Failed to load users: $e'));
    }
  }

  bool _mapEquals(Map<String, double> a, Map<String, double> b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key) || b[key] != a[key]) return false;
    }
    return true;
  }

}
