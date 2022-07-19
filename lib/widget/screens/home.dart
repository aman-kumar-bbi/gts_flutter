
import 'package:database_json/localStorage.dart';

import 'package:database_json/widget/screens/ifJsonHaveData.dart';

import 'package:flutter/material.dart';


class home extends StatefulWidget {
  List ListOfData;
  home({required this.ListOfData});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List wholeList = [];
  bool isLoader = true;
  TextEditingController searchFeildController = TextEditingController();

  late var item = widget.ListOfData;
  late List<dynamic> filterhouse = item;

  @override
  Widget build(BuildContext context) {
    wholeList = widget.ListOfData;
    print("listOfData ${widget.ListOfData}");
    return Scaffold(
        
        body: FutureBuilder(
          future: LocalStorage().readJson(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              

              return IfJsonHaveData(DataAfterFutureVuilder: snapshot.data as List<dynamic>);

            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Container(
                      height: 50,
                      width: 50,
                      child: const CircularProgressIndicator()));
            } else {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
          },
        ));
  }
}