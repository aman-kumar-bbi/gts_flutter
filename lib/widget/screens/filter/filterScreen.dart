import 'package:database_json/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/checkBoxModels.dart';

class filterScreen extends StatefulWidget {
  // const filterScreen({Key? key}) : super(key: key);
  var wholeListFromJson;
  filterScreen({this.wholeListFromJson});

  @override
  State<filterScreen> createState() => _filterScreenState();
}

bool isCategories = false;
bool isTables = false;
bool isTools = false;
bool isImages = false;
 bool _checkbox=false;

class _filterScreenState extends State<filterScreen> {
  List checkBoxList = [];
 
    Map <String,bool>typeMap={};
  
    filteringDataInList() {
    for (var i = 0; i < widget.wholeListFromJson.length; i++) {
      for (var p = 0; p < widget.wholeListFromJson[i]["type"].length; p++) {
        checkBoxList.add(widget.wholeListFromJson[i]["type"][p]);
      }
    }
    checkBoxList=checkBoxList.toSet().toList();
    // var debude=json.decode(checkBoxList).toString();
    print("checkBoxList $checkBoxList");

typeMap = {for (var item in checkBoxList) '$item' : false};
    print("checkBoxList420 $typeMap");
  }

  @override
  void initState() {
        filteringDataInList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("typemap ${typeMap["content"]}");
    return Scaffold(
        appBar: Constant().customAppBar("Filter", false, null),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 8, top: 10, left: 8.0),
                    child: categories(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, left: 30.0),
                    child: Container(
                        width: double.infinity,
                        height: 500,
                        child: subCategories(),
                            ),
                  ),
                 
                ],
              ),
              Container(
                width: double.infinity,
                height: 50,
                color: Colors.grey[300],
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                            style: TextButton.styleFrom(
                              side: const BorderSide(width: 150.0),
                              primary: Colors.purpleAccent,
                              backgroundColor: Colors.blue[900],
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                            style: TextButton.styleFrom(
                              side: const BorderSide(width: 150.0),
                              primary: Colors.purpleAccent,
                              backgroundColor: Colors.blue[900],
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Apply",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget categories() {
    return CheckboxListTile(
        title: Text(
          "Categories",
          style: TextStyle(color: Colors.black),
        ),
        value: isCategories,
        onChanged: (value) {
          setState(() {
              typeMap.updateAll((key, value) => true);
               isCategories=value!;
               
               if(isCategories==false){
                typeMap.updateAll((key, value) => false);
               }
               print("categories typeMap$typeMap");
          });
       
        });
  }

  Widget subCategories(){
    return ListView.builder(
                            itemCount: typeMap.length,
                            itemBuilder: (context, index) {
                              // String valuetoShow= CheckBoxMap.keys.elementAt(index);
                              return CheckboxListTile(
                                  title: Text(
                                    typeMap.keys.elementAt(index),
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  value: typeMap.values.elementAt(index),
                                  onChanged: (boolValue) {
                                    setState(() {
                                      typeMap.update(typeMap.keys.elementAt(index), (value) => boolValue!);

                                     
                                      // if (typeMap.values.elementAt(index)==true) {
                                        
                                      //   List onlyTrueValue=[];
                                        
                                      //   onlyTrueValue.add(typeMap.keys.elementAt(index));
                                      //   print("onlyTrueValue $onlyTrueValue");
                                      // }


                                      // typeMap.forEach((key, value) {
                                      //   print("for each $value");
                                      // });
                                          int count=0;
                                      for (var i = 0; i < typeMap.length; i++) {
                                        if (typeMap.values.elementAt(i)==true) {
                                          count++;
                                           
                                          if (count==typeMap.length) {
                                            setState(() {
                                              isCategories=true;
                                              
                                            });
                                          }else{
                                            setState(() {
                                              isCategories=false;
                                            });
                                          }
                                           continue;
                                        }
                                      }
                                      print("forloop ${typeMap.values.elementAt(index)}");
                                    });
                                  });
                            });
  }
}
