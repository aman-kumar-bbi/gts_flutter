import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  
  late Box box;
  List data =[];
    readJson() async {
    final String response = await rootBundle.loadString('assets/gts.json');
    data = await json.decode(response);
     return data;
   }

  Future openBox()async{
    print("DataoutOfbox $data");
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box =await Hive.openBox('data');
  }

  Future getAllData()async{
    await openBox();
    // await putData(data);
    var DbData = box.toMap().values.toList();
    // data=DbData;
    print("myData ${DbData}");

  }

  Future putData(data)async{
    await box.clear();
    for(var d in data){
      box.add(d);
    }
  }


}

