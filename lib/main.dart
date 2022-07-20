
import 'dart:io';

import 'package:database_json/localStorage.dart';
import 'package:database_json/widget/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Directory directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    LocalStorage().readJson();
    LocalStorage().openBox();
    LocalStorage().getAllData();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xF4F4F4),
            ),
      ),
      title: "DataBase Filter",
      home:home()
    );
  }
  
}
