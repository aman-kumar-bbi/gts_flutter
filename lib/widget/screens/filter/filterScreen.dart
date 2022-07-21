import 'package:database_json/constant.dart';
import 'package:database_json/widget/screens/ifJsonHaveData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';



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

class _filterScreenState extends State<filterScreen> {
  List checkBoxList = [];
  List testItem = [];
  Map<String, bool> typeMap = {};

  Map<String, dynamic> filteringDataInList() {
    for (var i = 0; i < widget.wholeListFromJson.length; i++) {
      for (var p = 0; p < widget.wholeListFromJson[i]["type"].length; p++) {
        checkBoxList.add(widget.wholeListFromJson[i]["type"][p]);
      }
    }
    checkBoxList = checkBoxList.toSet().toList();

    typeMap = {for (var item in checkBoxList) '$item': false};
    return typeMap;
  }

  @override
  void initState() {
    filteringDataInList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List list1=[];

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
                            onPressed: () { 
                              testing();

                                 list1 = testItem.toSet().toList();
                              for (var i = 0;
                                  i < widget.wholeListFromJson.length;
                                  i++) {
                                var list2 = widget.wholeListFromJson[i]["type"];
                                var finalData =
                                    (listEquals(list1, list2) == true);

                              }
                              var outputList = widget.wholeListFromJson
                                  .where(
                                      (o) => o["type"].toString() == "${list1}")
                                  .toList();
                                  Get.to(IfJsonHaveData(DataAfterFutureVuilder: outputList));

                                  setState(() {
                                    testItem=[];
                                  });
                            },
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
        title: const Text(
          "Categories",
          style: TextStyle(color: Colors.black),
        ),
        value: isCategories,
        onChanged: (value) {
          setState(() {
            typeMap.updateAll((key, value) => true);
            isCategories = value!;

            if (isCategories == false) {
              typeMap.updateAll((key, value) => false);
            }
          });
        });
  }

  Widget subCategories() {
    return ListView.builder(
        itemCount: typeMap.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
              title: Text(
                typeMap.keys.elementAt(index),
                style: TextStyle(color: Colors.grey[600]),
              ),
              value: typeMap.values.elementAt(index),
              onChanged: (boolValue) {
                setState(() {
                  typeMap.update(
                      typeMap.keys.elementAt(index), (value) => boolValue!);
                  int count = 0;
                  for (var i = 0; i < typeMap.length; i++) {
                    if (typeMap.values.elementAt(i) == true) {
                      count++;

                      if (count == typeMap.length) {
                        setState(() {
                          isCategories = true;
                        });
                      } else {
                        setState(() {
                          isCategories = false;
                        });
                      }
                      continue;
                    }
                  }
                });
              });
        });
  }

  testing() {
    for (var i = 0; i < typeMap.length; i++) {
      if (typeMap.values.elementAt(i) == true) {
        testItem.addAll({typeMap.keys.elementAt(i)});
        
      }
    }
  }
}
