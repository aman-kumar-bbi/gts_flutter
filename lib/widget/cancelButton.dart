import 'package:database_json/widget/searchBar.dart';
import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
 
  final searchFeildController;
    final List<dynamic> wholeListFromJson;

  const customButton({required this.searchFeildController,required this.wholeListFromJson});

  @override
  Widget build(BuildContext context) {
    return  
   Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8),
      child: Container(
          width: 60,
          child: TextButton(
              onPressed: () {
                 Stream<dynamic>?  myStream=cancelbroadcastList();
                FocusScope.of(context).requestFocus(new FocusNode());
                searchFeildController.clear();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ))),
    );
  

  }
   cancelbroadcastList(){
    return myStreamController.sink.add(wholeListFromJson);
  }

}