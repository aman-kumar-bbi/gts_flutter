import 'dart:convert';

import 'package:flutter/material.dart';



class GetCheckValue extends StatefulWidget{

  final ListOfJsonData;
  GetCheckValue({required this.ListOfJsonData});

  @override
  _GetCheckValueState createState() => new _GetCheckValueState();
}



class _GetCheckValueState extends State<GetCheckValue> {

  List outputList=[];

  @override
  void initState() {
    super.initState();
     outputList = widget.ListOfJsonData.where((o) => o["page"].toString() =="ENAS6458_2.0.0.0").toList();
  }
  // final myList=jsonDecode(_AnimatedMovies[]);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
   
   
    );
  }
}