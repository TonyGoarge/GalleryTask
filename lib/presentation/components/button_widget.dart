

import 'package:flutter/material.dart';


// defaulttextbutton({
//   final VoidCallback? onpress,
//   bool toUpperCase=true,
//   Color? background,
//
//   required String text,
// })=>Container(
//   width: double.infinity,
//   clipBehavior: ClipRRect(),
//   color: Colors.blue,
//   child:   TextButton(
//
//     onPressed: onpress,
//     child: Text(
//       toUpperCase?  text.toUpperCase():text,
//       style: TextStyle(
//         color: background,
//       ),
//     ),
//   ),
// );


Widget defaultbotton({
  width=double.infinity,
  // height=40.0,
  Color background=Colors.blue,
  bool toUpperCase=true,
  final double radius=0.0,
  final VoidCallback? function,
  required String text,
})=>

    Container(
      width: width,
      // height:height,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          toUpperCase?  text.toUpperCase():text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,

      ),

    );