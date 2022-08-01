import 'dart:convert';

import 'package:database_json/apiService.dart/getApi.dart';
import 'package:database_json/models/models.dart';
import 'package:flutter/services.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  
  // late Box box;
  // late List   data;
  //   readJson() async {
  //   final String response = await rootBundle.loadString('assets/gts.json');
    
  //   data = await json.decode(response);

  //   getAllData(data);
  //   return data;
  //  }

  // Future openBox(data)async{
  //   var dir = await getApplicationDocumentsDirectory();
  //   Hive.init(dir.path);
  //   box =await Hive.openBox('data');
  // }

  // Future getAllData(var data)async{
  //   await openBox(data);
  //   await box.clear();
  //   for(var d in data){
  //     box.add(d);
  //   }
  //   var DbData = box.toMap().values.toList();
  //   // data=DbData;
  //   passDataForUI(data);

  // }

  // Future putData(data)async{
  //   await box.clear();
  //   for(var d in data){
  //     box.add(d);
  //   }
  // }
  // passDataForUI(data){
  //   var NewData=ApiServices().getAllData();
  //   data= NewData;
  //   // var decodeNewData=json.decode(NewData);
  //   return data;
  // }


 List<dynamic> data=[];
 List ListOfwholeData=[];
  List test =[];

  Future<List<dynamic> > readJson() async {
    final response = await rootBundle.loadString('assets/gts.json');
    print("object $response");
    data = await json.decode(response) as List<dynamic>;
  test=data;

      //  saving data in hive
  var box  = Hive.box("dataFromJson");
  box.put('hardCodedJsonData','$data');

  // getting data from hive
  var box2  = Hive.box("dataFromJson");
  String jsonData=box2.get('hardCodedJsonData') ;
  data = jsonData.split('{');
  // ListOfwholeData=jsonData as List;
 
// MainData kaakakkak = jsonData;

  print("hive Data json ${data[1]}");
    return data;
   }
}


