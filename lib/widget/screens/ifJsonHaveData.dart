import 'dart:convert';

import 'package:database_json/models/checkBoxModels.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';
import '../cancelButton.dart';
import '../searchBar.dart';

class IfJsonHaveData extends StatelessWidget {
  var DataAfterFutureVuilder;
  IfJsonHaveData({required this.DataAfterFutureVuilder});
  TextEditingController searchFeildController = TextEditingController();

//   filteringDataForCheckBox(){
// List checkBoxList=[];
//     for (var i = 0; i < DataAfterFutureVuilder[1]["type"].length; i++) {
//     checkBoxList.add("${DataAfterFutureVuilder[1]["type"][i]}");

//     CheckBoxState(title:checkBoxList[i] );
//     }
//     // var debude=json.decode(checkBoxList).toString();
//     print("checkBoxList ${checkBoxList}");
    
//   }

  @override
  Widget build(BuildContext context) {
    // filteringDataForCheckBox();
    print("DataAfterFutureVuilder ${DataAfterFutureVuilder[1]["type"].length}");
    return Scaffold(
      appBar: Constant().customAppBar("Search", true,DataAfterFutureVuilder),
      body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey[300],
                        height: 50,
                        width: double.infinity,
                        child: Row(
                          children: [
                            SearchBar(
                                searchFeildController: searchFeildController,wholeListFromJson: DataAfterFutureVuilder  as List<dynamic>,),
                            customButton(
                              searchFeildController: searchFeildController,
                            ),
                          ],
                        ),
                      ),
                      // dataList(snapshot.data as List<dynamic>)
                      
                      dataList(DataAfterFutureVuilder  as List<dynamic>)
                    ],
                  ),
                ),
    );
  }
    Widget dataList(List DataList) {
    return Container(
        height: 640,
        width: double.infinity,
        child: ListView.builder(
          itemCount: DataList.length,
          itemBuilder: ((context, index) {
            return ListTile(
              title: Text("${DataList[index]['chapterName']}",maxLines: 2,overflow: TextOverflow.ellipsis,),
              subtitle: Text("${DataList[index]['page']}",maxLines: 1,overflow: TextOverflow.ellipsis),
            );
          }),
        ));
  }
}