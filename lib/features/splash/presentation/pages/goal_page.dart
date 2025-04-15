import 'package:calorify/core/theme.dart';
import 'package:calorify/features/splash/domain/entities/weight_goals.dart';
import 'package:calorify/features/splash/presentation/pages/personal_info_page.dart';
import 'package:flutter/material.dart';

///goal page which shows before registration
class GoalPage extends StatefulWidget {
  ///
  const GoalPage({super.key});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  int _selectedGoalIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Ваша ціль',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: weightGoals.length,
                  itemBuilder: (context, index) {
                    final WeightGoal goal = weightGoals[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedGoalIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          color: _selectedGoalIndex == index
                              ? lightGreen
                              : Colors.grey.shade200,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                child: Image.asset('assets/icons/food/${goal.imagePath}.png'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              goal.title,
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Text('Ми використовуємо цю інформацію для підрахунку ваших денних рекомендацій',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey.shade300),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_selectedGoalIndex == -1) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersonalInfoPage(
                        goal: weightGoals[_selectedGoalIndex].title,
                      ),
                    ),
                  );

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                ),
                child: Text(
                  'Розпочати',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
