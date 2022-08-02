
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
      required this.deviceType
      })
      : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

late StreamController myStreamController=StreamController();
late Stream myStream = myStreamController.stream.asBroadcastStream(); 

class _SearchBarState extends State<SearchBar> {
  @override
  Map<String, dynamic> ListForSearch = {};
  Widget build(BuildContext context) {
  List idList=widget.wholeListFromJson;
  var localVariableForDeviceCheck=widget.deviceType;
  double widthForContainer;
    localVariableForDeviceCheck=="tablet"?widthForContainer=700:widthForContainer=300;
    return ChangeNotifierProvider(
      create: (context) => searchList(idList: idList,wholeListFromJson: widget.wholeListFromJson),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, bottom: 8),
        child: wholeContainerWhichContainBoxAndIcon(localVariableForDeviceCheck, idList,widthForContainer)
      ),
    );
  }
  broadcastList(){
     return myStreamController.sink.add(staticValue.searchedList);
  }
  cancelbroadcastList(){
    return myStreamController.sink.add(widget.wholeListFromJson);
  }

  Widget searchBarWhiteBox(double Customwidth,List idList){
    return Container(
                  
                  width: Customwidth,
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

  Widget wholeContainerWhichContainBoxAndIcon(var localVariableForDeviceCheck ,List idList,double widthForThisContainerOnly){
    return Container(
           
            width: widthForThisContainerOnly,
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
               localVariableForDeviceCheck=="tablet"?searchBarWhiteBox(600, idList):searchBarWhiteBox(200, idList),
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

  }





