import 'package:calorify/features/splash/personal_info_page.dart';
import 'package:flutter/material.dart';

import '../../data/models/third_part/weight_goals.dart';
import '../../theme.dart';

class GoalPage extends StatefulWidget {
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
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Ваша ціль',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: weightGoals.length,
                  itemBuilder: (context, index) {
                    WeightGoal goal = weightGoals[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedGoalIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: _selectedGoalIndex == index
                              ? lightGreen
                              : Colors.grey.shade200,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                        margin: EdgeInsets.only(bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: Container(
                                margin: EdgeInsets.all(5),
                                child: Image.asset('assets/icons/food/${goal.imagePath}.png'),
                              ),
                            ),
                            SizedBox(width: 10),
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
                  if(_selectedGoalIndex != -1){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PersonalInfoPage(
                        goal: weightGoals[_selectedGoalIndex].title,
                      )),
                    );
                  }
                             },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                ),
                child: Text(
                  'Розпочати',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
