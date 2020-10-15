import 'package:flutter/material.dart';
import 'package:hello_flutter/Tab_Navigator/tab_navigator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        // "new_page":(context)=> NewRoute()
      },
      home: TabNavigator(),
    );
  }
}
