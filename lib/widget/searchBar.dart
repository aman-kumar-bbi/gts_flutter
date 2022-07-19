import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
 
  final searchFeildController;
  
  const SearchBar({required this.searchFeildController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8),
      child: Container(
          width: 300,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              SizedBox(
                width: 50,
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              Container(
                width: 200,
                child: TextFormField(
                  controller: searchFeildController,
                  decoration: const InputDecoration(
                      border: InputBorder.none, label: Text("Search")),
                ),
              ),
              Container(
                width: 50,
                child: IconButton(
                    onPressed: () {
                      searchFeildController.clear();
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey,
                    )),
              )
            ],
          )),
    );
  }


  Widget dataList(List wholeList) {
    return Container(
        height: 640,
        width: double.infinity,
        child: ListView.builder(
          itemCount: wholeList.length,
          itemBuilder: ((context, index) {
            return ListTile(
              title: Text("${wholeList[index]['page']}"),
            );
          }),
        ));
  }
  }
