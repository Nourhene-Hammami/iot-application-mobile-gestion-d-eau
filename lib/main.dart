import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dashboard_page.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT App',
      theme: ThemeData(
        primarySwatch: Colors.blue,



      ),
     home: SensorDataPage(), // Définissez votre page de tableau de bord comme page d'accueil
    );
  }
}

