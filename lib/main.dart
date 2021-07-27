import 'package:flutter/material.dart';
import 'package:mycamera/body.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Camera Implementation',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Body(imagePath: '',));
  }
}
