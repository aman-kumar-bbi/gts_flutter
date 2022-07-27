import 'package:flutter/material.dart';


class searchList  with ChangeNotifier{

searchList({this.idList,this.searchText,this.wholeListFromJson});

  final String? searchText;
  final List? idList;
  final List? wholeListFromJson;

  List idListtest=[];

  List<dynamic> searchFunction(searchText,idList,wholeListFromJson) {
    idList = wholeListFromJson
        .where((element) {
          final chapterName = element['text'] as String;
          return chapterName.toLowerCase().contains(searchText.toLowerCase());
        } )
        .toList();
        notifyListeners();  
        idListtest=idList;
        return idList;
  }



}
