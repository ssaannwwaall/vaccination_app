// import 'package:flutter/material.dart';
// import 'package:vaccination_app/Helper/MyColors.dart';
//
// class MyDropDown extends StatelessWidget {
//   double? _width;
//   List<String>? list;
//   final void Function() _function_handler;
//   final String _lable,_selected_item;
//
//
//   MyDropDown(this._width,this._selected_item,this._lable,this.list,this._function_handler);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: _width,
//       decoration: BoxDecoration(
//         shape: BoxShape.rectangle,
//         border: Border.all(
//             color: MyColors.color_black),
//         borderRadius:
//         BorderRadius.circular(5),
//       ),
//       child: Padding(
//         padding:
//         const EdgeInsets.all(3.0),
//         child: DropdownButton(
//           underline: SizedBox(),
//           elevation: 5,
//           hint: Text(_lable),
//           value: _selected_item,
//           onChanged: _function_handler,
//
//
//
//           //     (newValue) async {
//           //   setState(() {
//           //     _selectedCity =
//           //         newValue.toString();
//           //   });
//           //   await _loadTahsil(
//           //       _selectedCity!);
//           // },
//           items: list
//               ?.map((thislocation) {
//             return DropdownMenuItem(
//               child: new Text(
//                   thislocation),
//               value: thislocation,
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
