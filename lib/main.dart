import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Application name
      title: 'PhotoGallery',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            elevation: 1,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.blue),
          )),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.blue),
        ),
      ),
      themeMode: ThemeMode.system,
      home: HomeView(),
    );
  }
}
