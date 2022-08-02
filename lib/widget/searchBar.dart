
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
  SearchBar(
      {Key? key,
      required this.searchFeildController,
      required this.wholeListFromJson,
      required this.deviceType,
      })
      : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

late StreamController myStreamController=StreamController();
late Stream myStream = myStreamController.stream.asBroadcastStream(); 
  double customWidth=200;
    double customWithForSearchBox=200;
class _SearchBarState extends State<SearchBar> {
  @override
  Map<String, dynamic> ListForSearch = {};
  Widget build(BuildContext context) {
  List idList=widget.wholeListFromJson;

  
    return OrientationBuilder(
      builder: (context, orientation) {
        print("orientation $orientation");
        if (orientation==Orientation.portrait) {
          return ChangeNotifierProvider(
        create: (context) => searchList(idList: idList,wholeListFromJson: widget.wholeListFromJson),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8),
          child:wholeContainerConatinWhiteBox(idList,customWidth,customWithForSearchBox,true)
        ),
      );
        }else {
          return ChangeNotifierProvider(
        create: (context) => searchList(idList: idList,wholeListFromJson: widget.wholeListFromJson),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8),
          child:wholeContainerConatinWhiteBox(idList,customWidth,customWithForSearchBox,false)
        ),
      );
        }
      },

    );
  }
  broadcastList(){
     return myStreamController.sink.add(staticValue.searchedList);
  }
  cancelbroadcastList(){
    return myStreamController.sink.add(widget.wholeListFromJson);
  }
  // checkPhoneOrtablet(){
  //   if (widget.deviceType=="phone") {
  //   customWidth=300;
  //   customWithForSearchBox=200;
  // }else{
  //   customWidth=700;
  //   customWithForSearchBox=600;
  // }
  // }


Widget wholeContainerConatinWhiteBox(List idList,double customWidth,double customWithForSearchBox,bool isLandscape){
  print("islandscape bool $isLandscape");
  if (isLandscape==false) {
    customWidth=1200;
  }else{
     if (widget.deviceType=="phone") {
    customWidth=300;
    customWithForSearchBox=200;
  }else{
    customWidth=700;
    customWithForSearchBox=600;
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
                // whiteSearchBox(idList,customWithForSearchBox,isLandscape),
                Container(
                  width: 50,
                  child: IconButton(
                      onPressed: () {
                        
                        setState(() {
                          Stream<dynamic>?  myStream=cancelbroadcastList();
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

  Widget whiteSearchBox(List idList,double customWithForSearchBox,isLandscape){
    // isLandscape==true?customWithForSearchBox=1100:customWithForSearchBox=200;
    if (isLandscape==false) {
    customWidth=1200;
  }else{
     if (widget.deviceType=="phone") {
    customWidth=300;
    customWithForSearchBox=200;
  }else{
    customWidth=700;
    customWithForSearchBox=600;
  }
  }
    return Container(
                  width: customWithForSearchBox,
                  child: TextFormField(
                     cursorColor: Colors.black,
    
                      onChanged: (value) {

                        setState(() {
                          
                        staticValue.searchedList = Provider.of<searchList>(context, listen: false).searchFunction(value,idList,widget.wholeListFromJson);
                        });
                         Stream<dynamic>? myStream=broadcastList() ;
                      },
                      
                      controller: widget.searchFeildController,
                      decoration: const InputDecoration(
                        
                        border: InputBorder.none,
                      )),
                );
  }




  }




