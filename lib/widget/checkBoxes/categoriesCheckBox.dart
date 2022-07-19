// import 'package:flutter/material.dart';

// class Categories_CBox extends StatefulWidget {

// bool isImages;
// bool isCategories;
// bool isTools;
// bool isTables;

// Categories_CBox({required this.isCategories,required this.isImages,required this.isTools,required this.isTables});

//   @override
//   State<Categories_CBox> createState() => _Categories_CBoxState();
// }

// class _Categories_CBoxState extends State<Categories_CBox> {
//   @override
//   Widget build(BuildContext context) {
//     return CheckboxListTile(
//         title: Text(
//           "Categories",
//           style: TextStyle(color: Colors.black),
//         ),
//         value: widget.isCategories,
//         onChanged: (value) {
//           setState(() {
//             widget.isCategories = value!;
//             if (widget.isCategories == true) {
//               setState(() {
//                 widget.isImages = true;
//                 widget.isTables = true;
//                 widget.isTools = true;
//               });
//             } else {
//               widget.isImages = false;
//               widget.isTables = false;
//               widget.isTools = false;
//             }
//           });
//         });
//   }
// }