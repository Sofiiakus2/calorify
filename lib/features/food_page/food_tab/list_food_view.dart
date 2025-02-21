import 'package:calorify/features/food_page/food_tab/list_element_view.dart';
import 'package:flutter/material.dart';

class ListFoodView extends StatefulWidget {
  const ListFoodView({super.key});

  @override
  State<ListFoodView> createState() => _ListFoodViewState();
}

class _ListFoodViewState extends State<ListFoodView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index){
            return ListElementView();
          }
      ),
    );
  }
}
