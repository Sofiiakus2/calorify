import 'package:calorify/features/home/presentation/bloc/meal/total_summary_cubit.dart';
import 'package:calorify/features/home/presentation/bloc/meal/total_summary_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

///daily result block
class DailyResult extends StatefulWidget {
  const DailyResult({super.key});

  @override
  State<DailyResult> createState() => _DailyResultState();
}

class _DailyResultState extends State<DailyResult> {
  final TotalSummaryCubit _cubit = GetIt.instance<TotalSummaryCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.loadTotal();
  }

  @override
  // ignore: cyclomatic_complexity
  Widget build(BuildContext context) {
    return BlocBuilder<TotalSummaryCubit, TotalSummaryState>(
      bloc: _cubit,
      builder: (context, state){
        if (state is TotalSummaryLoading) {
          return CircularProgressIndicator();
        }else if (state is TotalSummaryLoaded){
          final total = state.total;

          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('ккал',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,),
                    ),
                    Text(total['calories']?.toStringAsFixed(0) ?? '0',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('б',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,),
                    ),
                    Text(total['proteins']?.toStringAsFixed(0) ?? '0',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('ж',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,),
                    ),
                    Text(total['fats']?.toStringAsFixed(0) ?? '0',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('в',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,),
                    ),
                    Text(total['carbohydrates']?.toStringAsFixed(0) ?? '0',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        return Text('');


      },
    );
  }
}
