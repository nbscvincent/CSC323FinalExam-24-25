import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/UI/recipe_list_screen.dart';
import 'package:recipes/core/features/Recipes/view%20model/recipe_View_Model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeViewModel()),
      ],
      child: MaterialApp(
        title: "Christian Recipe books",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const RecipeListScreen(),
      ),
    );
  }
}
