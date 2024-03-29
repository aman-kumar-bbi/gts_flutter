import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:share_plus/share_plus.dart';
import '../constant.dart';
import '../../constant/staticValue.dart';
import '../cancelButton.dart';
import '../searchBar.dart';
import 'package:intl/intl.dart';

class IfJsonHaveData extends StatefulWidget {
  List<dynamic> DataAfterFutureBuilder;
  bool? isfiltered;
  String deviceType;
  IfJsonHaveData({required this.DataAfterFutureBuilder, this.isfiltered,required this.deviceType});

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

  final df = DateFormat('dd-MM-yyyy');
  var timeStampInMilli = 1658859955000;
  List listWithoutTimeStamp = [];
  List listwithTimeStamp = [];
  List SumOfBothList = [];
  bool isNew = false;

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: Constant().customAppBar(
          "Search", widget.isfiltered ?? true, widget.DataAfterFutureBuilder,widget.deviceType),
      body: widget.DataAfterFutureBuilder.isEmpty
          ? const Center(
              child: Text("No item found"),
            )
          : SingleChildScrollView(
            child: Column(
                children: [
                  Container(
                    color: Colors.grey[300],
                    height: height * 0.065,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SearchBar(
                          searchFeildController: searchFeildController,
                          wholeListFromJson: widget.DataAfterFutureBuilder,
                          deviceType: widget.deviceType,
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
                        SumOfBothList = listwithTimeStamp + listWithoutTimeStamp;
                        return SingleChildScrollView(
                          child: SizedBox(
                              height: height - 161,
                              width: double.infinity,
                              child: ListView.builder(
                                itemCount: SumOfBothList.length,
                                itemBuilder: ((context, index) {
                                  return SumOfBothList[index]['timestamp'] != null
                                      ? ClipRect(
                                          child: Banner(
                                              message: "New",
                                              location: BannerLocation.topEnd,
                                              child: GestureDetector(
                                                onTap: (() {
                                                  print("button pressed");
                                                  setState(() {
                                                    SumOfBothList[index]
                                                        .removeWhere((key,
                                                                value) =>
                                                            key == "timestamp");
                                                  });
                                                  
                                                }),
                                                child: Column(
                                                  children: [
                                                    FocusedMenuHolder(
                                                      menuItems: [
                                                        FocusedMenuItem(
                                                            title: const Text("Share"),
                                                            onPressed: () async {
                                                              await Share.share(
                                                                  "title: ${SumOfBothList[index]['chapterName']},page: ${SumOfBothList[index]['page']},date: ${df.format(DateTime.fromMillisecondsSinceEpoch(timeStampInMilli * 1000))}");
                                                            },
                                                            trailingIcon:
                                                                const Icon(
                                                              Icons.share,
                                                              color: Colors.grey,
                                                            )),
                                                        FocusedMenuItem(
                                                            title:
                                                               const Text("BookMark"),
                                                            onPressed: () {
                                                              List testing =
                                                                  SumOfBothList[
                                                                          index]
                                                                      ['type'];
                                                              testing.add(
                                                                  "bookmark");
                                                              setState(() {
                                                                SumOfBothList[
                                                                            index]
                                                                        ['type'] =
                                                                    testing;
                                                              });
                                                              print(
                                                                  "bookmark ${testing.contains("bookmark")}");
                                                            },
                                                            trailingIcon:
                                                                const Icon(
                                                              Icons.bookmark,
                                                              color: Colors.grey,
                                                            )),
                                                        FocusedMenuItem(
                                                            title: const Text(
                                                                "Mark as read"),
                                                            onPressed: () {
                                                              markAsReadFunction(
                                                                  SumOfBothList[
                                                                      index]);
                                                            },
                                                            trailingIcon:
                                                                const Icon(
                                                              Icons
                                                                  .mark_as_unread,
                                                              color: Colors.grey,
                                                            )),
                                                      ],
                                                      onPressed: () {},
                                                      child: ListTile(
                                                          leading: SumOfBothList[
                                                                          index]
                                                                      ['type']
                                                                  .contains(
                                                                      "bookmark")
                                                              ? const Icon(
                                                                  Icons.bookmark,
                                                                  color:
                                                                      Colors.blue,
                                                                )
                                                              : Icon(null),
                                                          title:
                                                              Transform.translate(
                                                            offset:
                                                                Offset(-20, 0),
                                                            child: Text(
                                                              "${SumOfBothList[index]['chapterName']}",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          subtitle:
                                                              Transform.translate(
                                                            offset:
                                                               const Offset(-20, 0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            "${SumOfBothList[index]['page']}",
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          df.format(DateTime.fromMillisecondsSinceEpoch(timeStampInMilli *
                                                                              1000)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                    ),
                                                    Container(
                                                        height: 1,
                                                        color: Colors.grey,
                                                        width: width)
                                                  ],
                                                ),
                                              )),
                                        )
                                      : Column(
                                          children: [
                                            FocusedMenuHolder(
                                              menuItems: [
                                                FocusedMenuItem(
                                                    title: Text("Share"),
                                                    onPressed: () async {
                                                      await Share.share(
                                                          "title: ${SumOfBothList[index]['chapterName']},page: ${SumOfBothList[index]['page']}");
                                                    },
                                                    trailingIcon: const Icon(
                                                      Icons.share,
                                                      color: Colors.grey,
                                                    )),
                                                FocusedMenuItem(
                                                    title: const Text("BookMark"),
                                                    onPressed: () {
                                                      List testing =
                                                          SumOfBothList[index]
                                                              ['type'];
                                                      testing.add("bookmark");
                                                      setState(() {
                                                        SumOfBothList[index]
                                                            ['type'] = testing;
                                                      });
                                                      
                                                    },
                                                    trailingIcon: const Icon(
                                                        Icons.bookmark,
                                                        color: Colors.grey))
                                              ],
                                              onPressed: () {},
                                              child: ListTile(
                                                  leading: SumOfBothList[index]
                                                              ['type']
                                                          .contains("bookmark")
                                                      ? const Icon(
                                                          Icons.bookmark,
                                                          color: Colors.blue,
                                                        )
                                                      : const Icon(
                                                          null),
                                                  title: Transform.translate(
                                                    offset:const Offset(-20, 0),
                                                    child: Text(
                                                      "${SumOfBothList[index]['chapterName']}",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  subtitle: Transform.translate(
                                                    offset:const Offset(-20, 0),
                                                    child: Row(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                "${SumOfBothList[index]['page']}",
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                            Container(
                                                height: 1,
                                                color: Colors.grey,
                                                width: width)
                                          ],
                                        );
                                }),
                              )),
                        );
                      } else {
                        return const Center(
                          child: Text("Not Such Data"),
                        );
                      }
                    },
                  ),
                ],
              ),
          ),
    );
  }

  void markAsReadFunction(var index) {
    setState(() {
      index.removeWhere((key, value) => key == "timestamp");
    });
  }
}