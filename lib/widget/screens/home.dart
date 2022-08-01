import 'package:database_json/Database/localStorage.dart';
import 'package:database_json/widget/screens/ifJsonHaveData.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List wholeList = [];
  bool isLoader = true;
  TextEditingController searchFeildController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: FutureBuilder(
          // future: LocalStorage().passDataForUI(LocalStorage().readJson()),
          future: LocalStorage().readJson() ,
          builder: (context, snapshot) {
            var dataFromFilter=snapshot.data;

            if (snapshot.connectionState == ConnectionState.done) {
              return IfJsonHaveData(DataAfterFutureBuilder: snapshot.data as List<dynamic>);
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