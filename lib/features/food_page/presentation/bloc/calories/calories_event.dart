import 'package:equatable/equatable.dart';

/// Events
abstract class CaloriesEvent extends Equatable {
  ///
  const CaloriesEvent();

  @override
  List<Object?> get props => [];
}

///on changed
class CaloriesChangedEvent extends CaloriesEvent {
  final double weight;

  ///Constructor
  const CaloriesChangedEvent(this.weight);

  @override
  List<Object?> get props => [weight];
}
