import 'package:database_json/apiService.dart/getApi.dart';
import 'package:database_json/widget/screens/ifJsonHaveData.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool hasInternet = false;
  List wholeList = [];
  bool isLoader = true;
  TextEditingController searchFeildController = TextEditingController();
  var box = Hive.box("dataFromJson");
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: FutureBuilder(
      future:ApiServices().getAllData(),
      builder: (context, snapshot) {  
        var dataFromFilter = snapshot.data;
        if (snapshot.connectionState == ConnectionState.done) {
          return IfJsonHaveData(
              DataAfterFutureBuilder: dataFromFilter as List<dynamic>);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
      },
    ));
  }
}
