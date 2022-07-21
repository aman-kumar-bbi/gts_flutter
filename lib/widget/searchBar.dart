import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final searchFeildController;
  var wholeListFromJson;
  SearchBar(
      {Key? key, required this.searchFeildController, required this.wholeListFromJson}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  List ListForSearch=[];
  List listAfterFiltertheData=[];
  Widget build(BuildContext context) {
    ListForSearch=widget.wholeListFromJson;

filterListForSearch();
print("filterListForSearch ${filterListForSearch()}");
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
                  onFieldSubmitted: (value) =>searchFunction(value.toString()),
                  controller: widget.searchFeildController,
                  decoration: const InputDecoration(
                      border: InputBorder.none, )
                ),
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


  searchFunction(String searchText ) {
    var outputList = listAfterFiltertheData.forEach((element) =>print(" finallist ${element==searchText}"));
        
        
  }


   filterListForSearch(){
    
     ListForSearch.forEach((element) {listAfterFiltertheData.add(element["chapterName"]); });
    print("listAfterFiltertheData $listAfterFiltertheData");
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