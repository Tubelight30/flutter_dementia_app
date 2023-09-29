import 'package:basiclogin/constants/routes.dart';
import 'package:basiclogin/ui/screens/home_page.dart';
import 'package:basiclogin/ui/screens/intermediate_screen.dart';
import 'package:basiclogin/ui/screens/quiz_screen.dart';
import 'package:basiclogin/ui/screens/relations_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:basiclogin/ui/main_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(),
    darkTheme: ThemeData.light(),
    home: const MainView(),
    routes: {
      myfirstRoute: (context) => const Home_Screen(),
      intermediate: (context) => const IntermediateScreen(),
      relation: (context) => const RelationScreen(),
      quiz: (context) => const QuizScreen(),
    },
  ));
}
