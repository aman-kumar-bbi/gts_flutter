import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
 
  final searchFeildController;
  
  const customButton({required this.searchFeildController});

  @override
  Widget build(BuildContext context) {
    return  
   Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8),
      child: Container(
          width: 60,
          child: TextButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                searchFeildController.clear();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ))),
    );
  

  }
}