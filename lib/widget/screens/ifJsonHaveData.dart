import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';

import '../../constant/staticValue.dart';
import '../cancelButton.dart';
import '../searchBar.dart';
import 'package:intl/intl.dart';

class IfJsonHaveData extends StatefulWidget {
  List<dynamic> DataAfterFutureBuilder;
  IfJsonHaveData({required this.DataAfterFutureBuilder});

  @override
  static ValueNotifier entervalue = ValueNotifier('');

  @override
  State<IfJsonHaveData> createState() => _IfJsonHaveDataState();
}

class _IfJsonHaveDataState extends State<IfJsonHaveData> {
  TextEditingController searchFeildController = TextEditingController();

  @override
  void initState() {
    staticValue.searchedList = widget.DataAfterFutureBuilder;
    super.initState();
  }

  final df = new DateFormat('dd-MM-yyyy');
  var timeStampInMilli = 1658878732000;
  var convertTimestamp;
  List listWithoutTimeStamp = [];
  List listwithTimeStamp = [];
  List SumOfBothList = [];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constant()
          .customAppBar("Search", true, widget.DataAfterFutureBuilder),
      body: widget.DataAfterFutureBuilder.isEmpty
          ? const Center(
              child: Text("No item found"),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.grey[300],
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        SearchBar(
                          searchFeildController: searchFeildController,
                          wholeListFromJson: widget.DataAfterFutureBuilder,
                        ),
                        customButton(
                          searchFeildController: searchFeildController,
                          wholeListFromJson: widget.DataAfterFutureBuilder,
                        ),
                      ],
                    ),
                  ),
                  // Stream
                  StreamBuilder(
                    initialData: staticValue.searchedList,
                    stream: myStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List thisIsMainData = snapshot.data as List;
                        // listwithTimeStamp=thisIsMainData;
                        listwithTimeStamp = thisIsMainData.where((element) {
                          return element['timestamp'] != null;
                        }).toList();
                        listWithoutTimeStamp = thisIsMainData.where((element) {
                          return element['timestamp'] == null;
                        }).toList();
                        SumOfBothList=listwithTimeStamp+listWithoutTimeStamp;
                       
                        return Container(
                            height: 640,
                            width: double.infinity,
                            child: ListView.builder(
                              itemCount: SumOfBothList.length,
                              itemBuilder: ((context, index) {
                                // timeStampInMilli=int.parse(thisIsMainData[index]['timestamp']?? 100);
                                return SumOfBothList[index]['timestamp'] !=
                                        null
                                    ? ClipRect(
                                        child: Banner(
                                          message: "New",
                                          location: BannerLocation.topEnd,
                                          child: ListTile(
                                              onTap: (() {
                                                
                                                setState(() {
                                                  SumOfBothList[index]
                                                      .removeWhere((key,
                                                              value) =>
                                                          key == "timestamp");
                                                });
                                              }),
                                              title: Text(
                                                "${SumOfBothList[index]['chapterName']}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              subtitle: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                          "${SumOfBothList[index]['page']}",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                      // timeStampInMilli=thisIsMainData[index]['timestamp']==null?timeStampInMilli:thisIsMainData[index]['timestamp'],
                                                      // timeStampInMilli="${thisIsMainData[index]['timestamp']}",

                                                      // convertTimestamp=int.parse()

                                                      Text(
                                                        df.format(DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                                timeStampInMilli *
                                                                    1000)),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ),
                                      )
                                    : ListTile(
                                        title: Text(
                                          "${SumOfBothList[index]['chapterName']}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                    "${SumOfBothList[index]['page']}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                                // timeStampInMilli=thisIsMainData[index]['timestamp']==null?timeStampInMilli:thisIsMainData[index]['timestamp'],
                                              ],
                                            ),
                                          ],
                                        ));
                              }),
                            ));
                      } else {
                        return const Center(
                          child: Text("Not Such Data"),
                        );
                      }
                    },
                  ),
                  // dataList(DataAfterFutureBuilder)
                ],
              ),
            ),
    );
  }
}
