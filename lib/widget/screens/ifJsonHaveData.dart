import 'package:flutter/material.dart';

import '../../constant.dart';
import '../cancelButton.dart';
import '../searchBar.dart';

class IfJsonHaveData extends StatelessWidget {
  var DataAfterFutureVuilder;
  IfJsonHaveData({required this.DataAfterFutureVuilder});
  TextEditingController searchFeildController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("dataAfterFutureBuilder ${DataAfterFutureVuilder}");

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
                                searchFeildController: searchFeildController),
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