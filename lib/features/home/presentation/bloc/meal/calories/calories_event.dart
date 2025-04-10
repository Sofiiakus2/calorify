import 'package:bloc/bloc.dart';

abstract class CaloriesEvent{
  const CaloriesEvent();
}

class CaloriesChangedEvent extends CaloriesEvent{
  final double weight;

  CaloriesChangedEvent(this.weight);
}