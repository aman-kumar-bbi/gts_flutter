// import 'package:database_json/widget/checkBoxes/categoriesCheckBox.dart';
// import 'package:flutter/material.dart';


// class Subcategories extends StatefulWidget {
// bool isImages;
// bool isCategories;
// bool isTools;
// bool isTables;
// Subcategories({required this.isCategories,required this.isImages,required this.isTables,required this.isTools});

//   @override
//   State<Subcategories> createState() => _SubcategoriesState();
// }

// class _SubcategoriesState extends State<Subcategories> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CheckboxListTile(
//             title: Text(
//               "Tables",
//               style: TextStyle(color: Colors.grey[600]),
//             ),
//             value: widget.isTables,
//             onChanged: (value) {
//               setState(() {
//                 widget.isTables = value!;
//                 Categories_CBox(isCategories: widget.isCategories,widget.isImages,widget.isTools,widget.isTables);
//               });
//             }),
//         CheckboxListTile(
//             title: Text(
//               "Tools",
//               style: TextStyle(color: Colors.grey[600]),
//             ),
//             value: widget.isTools,
//             onChanged: (value) {
//               setState(() {
//                 widget.isTools = value!;
//                 Categories_CBox();
//               });
//             }),
//         CheckboxListTile(
//             title: Text(
//               "Images",
//               style: TextStyle(color: Colors.grey[600]),
//             ),
//             value: widget.isImages,
//             onChanged: (value) {
//               setState(() {
//                 widget.isImages = value!;
//                 checkCatergories();
//               });
//             }),
//       ],
//     );
//   }
// }