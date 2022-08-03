import 'dart:async';

import 'package:database_json/constant/staticValue.dart';
import 'package:database_json/widget/screens/ifJsonHaveData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../providers/SearchListProvider.dart';

class SearchBar extends StatefulWidget {
  final searchFeildController;
  final List<dynamic> wholeListFromJson;
  String deviceType;
  SearchBar({
    Key? key,
    required this.searchFeildController,
    required this.wholeListFromJson,
    required this.deviceType,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

late StreamController myStreamController = StreamController();
late Stream myStream = myStreamController.stream.asBroadcastStream();
double customWidth = 200;
double customWithForSearchBox = 200;
bool? isportrait;

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      print("portrait h");
      isportrait = true;
    } else {
      print("landscape h");
      isportrait = false;
    }
    List idList = widget.wholeListFromJson;
    double width = MediaQuery.of(context).size.width;
    return 
           ChangeNotifierProvider(
            create: (context) => searchList(
                idList: idList, wholeListFromJson: widget.wholeListFromJson),
            child: Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                child: wholeContainerConatinWhiteBox(
                    idList, customWidth, customWithForSearchBox, isportrait!,context)),
          );     
  }

  broadcastList() {
    return myStreamController.sink.add(staticValue.searchedList);
  }

  cancelbroadcastList() {
    return myStreamController.sink.add(widget.wholeListFromJson);
  }

  Widget wholeContainerConatinWhiteBox(List idList, double customWidth,
      double customWithForSearchBox, bool isLandscape,BuildContext context) {
          double width = MediaQuery.of(context).size.width;

    if (isLandscape == false) {
      customWidth = 1200;
      customWithForSearchBox = 1100;
    } else {
      if (widget.deviceType == "phone") {
        customWidth = width*0.8;
        customWithForSearchBox = width*0.78;
      } else {
        customWidth = width*0.9;
        customWithForSearchBox = width*0.65;
      }
    }
    return Container(
        width: customWidth,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            const SizedBox(
              width: 50,
              child: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            whiteSearchBox(idList,customWithForSearchBox,isLandscape,context),
            Container(
              width: 50,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      Stream<dynamic>? myStream = cancelbroadcastList();
                    });
                    widget.searchFeildController.clear();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.grey,
                  )),
            )
          ],
        ));
  }

  Widget whiteSearchBox(
      List idList, double customWithForSearchBox, isLandscape,BuildContext context) {
          double width = MediaQuery.of(context).size.width;

    if (isLandscape == false) {
      customWidth =  width*1;
      customWithForSearchBox = width*0.85;
    } else {
      if (widget.deviceType == "phone") {
          customWidth = width*0.8;
        customWithForSearchBox = width*0.54;
      } else {
        customWidth = width*0.9;
        customWithForSearchBox = width*0.77;
      }
    }
    return Container(
      width: customWithForSearchBox,
      child: TextFormField(
          cursorColor: Colors.black,
          onChanged: (value) {
            setState(() {
              staticValue.searchedList =
                  Provider.of<searchList>(context, listen: false)
                      .searchFunction(value, idList, widget.wholeListFromJson);
            });
            Stream<dynamic>? myStream = broadcastList();
          },
          controller: widget.searchFeildController,
          decoration: const InputDecoration(
            border: InputBorder.none,
          )),
    );
  }
}
