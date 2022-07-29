import 'package:database_json/widget/constant.dart';
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
bool isSwitched = true;

class _filterScreenState extends State<filterScreen> {
  List checkBoxList = [];
  List testItem = [];
  Map<String, bool> typeMap = {};
  List OrItemsList = [];

  Map<String, dynamic> filteringDataInList() {
    var list1 = ["content", "image"];
    for (var i = 0; i < widget.wholeListFromJson.length; i++) {
      for (var p = 0; p < widget.wholeListFromJson[i]["type"].length; p++) {
        checkBoxList.add(widget.wholeListFromJson[i]["type"][p]);
        // if (list1.contains(widget.wholeListFromJson[i]["type"]) ) {

        // }
      }
    }
    checkBoxList = checkBoxList.toSet().toList();
    print("checkBoxList $checkBoxList");

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
    double height = MediaQuery.of(context).size.height;

    List list1 = [];

    return Scaffold(
        appBar: Constant().customAppBar("Filter", false, null),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8, top: 10, left: 8.0),
                  child: categories(),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: height / 2,
                    child: subCategories(),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("And functionaltiy",style: TextStyle(fontWeight: FontWeight.bold),),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          print(isSwitched);
                        });
                      },
                    ),
                    const Text("Or functionaltiy",style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: height * 0.06,
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
                                var outputList = widget.wholeListFromJson
                                    .where((o) =>
                                        o["type"].toString() == "${list1}")
                                    .toList();

                                isSwitched == false
                                    ? Get.to(
                                        IfJsonHaveData(
                                          DataAfterFutureBuilder: outputList,
                                          isfiltered: false,
                                        ),
                                      )
                                    : OrFunctionOnApplyButton(list1);
                                Get.to(
                                  IfJsonHaveData(
                                    DataAfterFutureBuilder: OrItemsList,
                                    isfiltered: false,
                                  ),
                                );
                                print("tesing list1 ${list1}");
                                setState(() {
                                  testItem = [];
                                  OrItemsList = [];
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
                ),
              ],
            )
          ],
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
    print("typeMap testing $typeMap");
  }

  OrFunctionOnApplyButton(List list1) {
    for (var i = 0; i < widget.wholeListFromJson.length; i++) {
      for (var p = 0; p < widget.wholeListFromJson[i]["type"].length; p++) {
        print(" each list ${widget.wholeListFromJson[i]["type"]}");
        if (list1.contains(widget.wholeListFromJson[i]["type"][p])) {
          OrItemsList.add(widget.wholeListFromJson[i]);
          break;
        }
      }
    }
  }
}
