
import 'package:Task/screen/Favorite.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:Task/screen/HomeScreen.dart';
import 'package:Task/screen/Splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
const favorites_box = "favorites_box";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(favorites_box);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstSplash(),
      routes: {
        'favorite': ((context) => Favorite())
      },
    );
  }
}



