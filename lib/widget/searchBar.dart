import 'package:database_json/widget/screens/ifJsonHaveData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBar extends StatefulWidget {
  final searchFeildController;
  final List<dynamic> wholeListFromJson;
  SearchBar(
      {Key? key,
      required this.searchFeildController,
      required this.wholeListFromJson})
      : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Map<String, dynamic> ListForSearch = {};
  List idList =[];
   List testingList =[];
  List listAfterFiltertheData = [];
  Widget build(BuildContext context) {
    // ListForSearch = widget.wholeListFromJson[0];
    // List idList =
    //   widget.wholeListFromJson.where((element) => element['chapterName']==).toList();
//  widget.wholeListFromJson.where((element) => element['chapterName']=="Practical tips for safe and effective lead implantation").toList();

    // print("aman $idList");


    print("ListForSearch $testingList");
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8),
      child: Container(
          width: 300,
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
              Container(
                width: 200,
                child: TextFormField(
                    // onFieldSubmitted: (value) {
                    //   Get.to(IfJsonHaveData(DataAfterFutureVuilder: idList));
                    // },
                       
                    onChanged: (value){
                      searchFunction(value);
                      // Get.to(IfJsonHaveData(DataAfterFutureVuilder: idList));
                    },
                    onFieldSubmitted: (value){Get.to(IfJsonHaveData(DataAfterFutureVuilder: idList));},
                    controller: widget.searchFeildController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    )),
              ),
              Container(
                width: 50,
                child: IconButton(
                    onPressed: () {
                      widget.searchFeildController.clear();
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.grey,
                    )),
              )
            ],
          )),
    );
  }

  // searchFunction(String searchText ) {
  //   var outputList = widget.wholeListFromJson
  //       .where((o) => o["text"] == searchText)
  //       .toList();
  //       setState(() {
  //         widget.wholeListFromJson=outputList;
  //       });
  //       print("searchtesting $outputList");
  // }

  searchFunction(String searchText) {
 idList =
      widget.wholeListFromJson.where((element) => element['chapterName']==searchText).toList();


  }

  filterListForSearch() {
    for (var i = 0; i < ListForSearch.length; i++) {
      // ListForSearch[i].forEach((element) {listAfterFiltertheData.add(element["chapterName"]=="Anchor knot for securing the lead"); });
    }

    if (listAfterFiltertheData == true) {
      print("trueData $listAfterFiltertheData");
    }
    return ListForSearch.forEach((k, v) => ListForSearch);
  }



}
        // widget.wholeListFromJson.map((e) => {e['chapterName']=="Categories of consensus statements"}).toList();
// (e) => {e['chapterName']=="Categories of consensus statements"}