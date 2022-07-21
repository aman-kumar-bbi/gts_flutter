
import 'package:database_json/widget/screens/filter/filterScreen.dart';
import 'package:database_json/widget/screens/ifJsonHaveData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Constant {
  
 Color APP_BASIS_COLOR=Color(0xF4F4F4);

AppBar customAppBar(String title,bool ishowButton,var wholeListFromJson){
  return AppBar(
      



        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue[900],
          ),
        ),
        centerTitle: true,
        
        actions: [
          ishowButton==true? IconButton(
              onPressed: () =>Get.to(filterScreen(wholeListFromJson: wholeListFromJson,)),
              icon: Image.asset(
                'assets/menuIcon.png',
              )):SizedBox()
        ],
        elevation: 0,
        backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: false,
      );
}

}

