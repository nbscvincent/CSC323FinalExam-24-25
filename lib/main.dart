import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/Viewmodel/view_model.dart';
import 'package:recipes/repositories/repository.dart';
import 'package:recipes/screens/recipe_list_screen.dart';
import 'package:recipes/screens/recipe_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RecipeViewModel(RecipeRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Recipe App',
        initialRoute: '/',
        routes: {
          '/': (context) => const RecipeListScreen(),
          '/details': (context) => RecipeDetailScreen(),
        },
      ),
    );
  }
}
