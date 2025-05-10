
abstract class TotalSummaryState {}

class TotalSummaryInitial extends TotalSummaryState {}

class TotalSummaryLoading extends TotalSummaryState {}

class TotalSummaryLoaded extends TotalSummaryState {
  Map<String, double> total;

  TotalSummaryLoaded({required this.total});
}

class TotalSummaryError extends TotalSummaryState {
  final String message;

  TotalSummaryError({required this.message});
}
