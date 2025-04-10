import 'package:calorify/features/home/presentation/bloc/water/water_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///water screen
class WaterView extends StatelessWidget {
  ///
  const WaterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<WaterCubit, WaterState>(
          builder: (context, state) {
            return Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(state.glassesCount, (index) {
                return GestureDetector(
                  onTap: () {
                    context.read<WaterCubit>().toggleGlassFill(index);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.water_drop,
                        size: 44.0,
                        color: state.isFilled[index]
                            ? const Color(0xFFbdcbea)
                            : Colors.grey[300],
                      ),
                      if (!state.isFilled[index])
                        const Icon(
                          Icons.add,
                          size: 20.0,
                          color: Colors.black,
                        ),
                    ],
                  ),
                );
              }),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () {
                  context.read<WaterCubit>().removeGlass();
                },
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () {
                  context.read<WaterCubit>().addGlass();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
