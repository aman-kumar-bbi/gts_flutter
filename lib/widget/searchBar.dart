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
  Widget build(BuildContext context) {
    print("searchFeildController ${widget.searchFeildController}");
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
                  onFieldSubmitted: (value) =>SearchFunction(value.toString()),
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

 

  SearchFunction(String searchText ) {
    var outputList = widget.wholeListFromJson
        .where((o) => o["page"].toString() == "$searchText")
        .toList();
        
        print("SearchList $outputList");
        setState(() {
          widget.wholeListFromJson=outputList;
        });
  }
}