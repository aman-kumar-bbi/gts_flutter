import 'package:database_json/constant.dart';
import 'package:database_json/models/models.dart';
import 'package:database_json/widget/screens/ifJsonHaveData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  
  @override
  Widget build(BuildContext context) {
    print("test ${widget.wholeListFromJson[21]["type"]}");
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
                    child: subCategories(),
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
                              ApplyButtonFunction();
                              print("ApplyButtonFunction ${ApplyButtonFunction}");
                              Get.to(IfJsonHaveData(DataAfterFutureVuilder: ApplyButtonFunction()));
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
        title: Text(
          "Categories",
          style: TextStyle(color: Colors.black),
        ),
        value: isCategories,
        onChanged: (value) {
          setState(() {
            isCategories = value!;
            if (isCategories == true) {
              setState(() {
                isImages = true;
                isTables = true;
                isTools = true;
              });
            } else {
              isImages = false;
              isTables = false;
              isTools = false;
            }
          });
        });
  }

  Widget subCategories() {
    return Column(
      children: [
        CheckboxListTile(
            title: Text(
              "Tables",
              style: TextStyle(color: Colors.grey[600]),
            ),
            value: isTables,
            onChanged: (value) {
              setState(() {
                isTables = value!;
                checkCatergories();
              });
            }),
        CheckboxListTile(
            title: Text(
              "Tools",
              style: TextStyle(color: Colors.grey[600]),
            ),
            value: isTools,
            onChanged: (value) {
              setState(() {
                isTools = value!;
                checkCatergories();
              });
            }),
        CheckboxListTile(
            title: Text(
              "Images",
              style: TextStyle(color: Colors.grey[600]),
            ),
            value: isImages,
            onChanged: (value) {
              setState(() {
                isImages = value!;
                checkCatergories();
              });
            }),
      ],
    );
  }

  checkCatergories() {
    if (isTables == true && isTools == true && isImages == true) {
      setState(() {
        isCategories = true;
      });
    } else {
      setState(() {
        isCategories = false;
      });
    }
  }

  List<dynamic> ApplyButtonFunction() {
    if (isTables == true &&
        isImages == false &&
        isTools == false &&
        isCategories == false) {
      var outputList = widget.wholeListFromJson
          .where((o) => o["type"].toString() == "[table]")
          .toList();
          print("output table $outputList");
      return outputList;
    } else if (isTables == false &&
        isImages == true &&
        isTools == false &&
        isCategories == false) {
      var outputList = widget.wholeListFromJson
          .where((o) => o["type"].toString() == "[image]")
          .toList();
           print("outPut $outputList");
      return outputList;
    } else if (isTables == false &&
        isImages == false &&
        isTools == true &&
        isCategories == false) {
      var outputList = widget.wholeListFromJson
          .where((o) => o["type"].toString() == "[content]")
          .toList();
          print("outPut $outputList");
      return outputList;
    } else if (isTables == false &&
        isImages == true &&
        isTools == true &&
        isCategories == false) {
      var outputList = widget.wholeListFromJson
          .where((o) => o["type"].toString() == "[content, image]")
          .toList();
          print("output images and tools $outputList");
      return outputList;
    } else if (isTables == true &&
        isImages == false &&
        isTools == true &&
        isCategories == false) {
      var outputList = widget.wholeListFromJson
          .where((o) => o["type"].toString() == "[content, table]")
          .toList();
          print("outPut $outputList");
      return outputList;
    } else if (isTables == false &&
        isImages == true &&
        isTools == true &&
        isCategories == false) {
      var outputList = widget.wholeListFromJson
          .where((o) => o["type"].toString() == "[content,image]")
          .toList();
          print("output image tools $outputList");
      return outputList;
    } else if (isTables == false &&
        isImages == true &&
        isTools == true &&
        isCategories == false) {
      var outputList = widget.wholeListFromJson
          .where((o) => o["type"].toString() == "[image, table]")
          .toList();
          print("output image table $outputList");
      return outputList;
    } 
    else if (isTables == true &&
        isImages == true &&
        isTools == true &&
        isCategories == true) {
      var outputList = widget.wholeListFromJson
          .where((o) => o["type"].toString() == "[content, image, table]".toString())
          .toList();
          print("output image tools table $outputList");
      return outputList;
    }
    else {
      return widget.wholeListFromJson;
    }
  }
}
