import 'package:database_json/widget/screens/ifJsonHaveData.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  // const SearchScreen({Key? key}) : super(key: key);
  List<dynamic> DataAfterFutureBuilder;
  BuildContext bContext;

  SearchScreen({required this.DataAfterFutureBuilder,required this.bContext});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
  String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    print("type ${data.size.shortestSide < 600 ? 'phone' : 'tablet'}");
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }

   getDevicedeviceOrientation(BuildContext context) {
     isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  }
  var isPortrait;
  late String MobileOrTable;
  // late String deviceOrientation;
class _SearchScreenState extends State<SearchScreen> {
  
  @override
  void initState() {
    MobileOrTable=getDeviceType();
    // deviceOrientation=getDevicedeviceOrientation(widget.bContext);
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // print("isPortrait $deviceOrientation");
    return IfJsonHaveData(DataAfterFutureBuilder: widget.DataAfterFutureBuilder, deviceType: MobileOrTable);
  }
}