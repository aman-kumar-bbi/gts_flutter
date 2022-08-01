import 'dart:convert';

import 'package:database_json/Database/localStorage.dart';
import 'package:database_json/widget/screens/ifJsonHaveData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List wholeList = [];
  bool isLoader = true;
  TextEditingController searchFeildController = TextEditingController();

  var mainGlobal;

    onlyReadJson()async{
    final String response = await rootBundle.loadString('assets/gts.json');
    
    var offlinedata = await json.decode(response);
    mainGlobal=offlinedata;
    return offlinedata;
  }
  // updateDataInHinve(var dataFromFilter){
  //    Hive.box('data').putAt(0, dataFromFilter);
  // }
  @override
  Widget build(BuildContext context) {
onlyReadJson();
 
    return Scaffold(
        body: FutureBuilder(
          future: LocalStorage().passDataForUI(LocalStorage().readJson()),
          builder: (context, snapshot) {
            var dataFromFilter=snapshot.data;
            var offlineData;
            if (dataFromFilter==null) {
              dataFromFilter=mainGlobal;
              // updateDataInHinve(dataFromFilter);
            }else{
              dataFromFilter;
            }
            if (snapshot.connectionState == ConnectionState.done) {
              
              return IfJsonHaveData(DataAfterFutureBuilder: dataFromFilter as List<dynamic>);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator());
            } else {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
          },
        ));
  }

}