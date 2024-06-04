import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultformfield({
  required TextEditingController? controller,
  required TextInputType  type,
  String? hintText,
  required String label,
  final FormFieldValidator? validate,
  TextStyle? hintStyle =const TextStyle(
    color: Colors.black,
  ),


  Function(String)? onChanged ,
  Function(String)? onSubmit ,
  IconData? suffix,
  VoidCallback? suffixPressed,
   IconData? prefix,
  VoidCallback? onPressedfun,
  bool obscureText = false,

})=> Material(
  elevation: 0.0,
  borderRadius: BorderRadius.circular(30.0),
  child: Container(
    child:TextFormField(
      controller:controller,
      keyboardType:type,
      onChanged: onChanged,
      onFieldSubmitted:onSubmit,
      onTap: suffixPressed,
      validator: validate,
      obscureText:obscureText,
      style: TextStyle(
        color: Colors.black,
      ),
      cursorColor: Colors.transparent,

      decoration: InputDecoration(
        hintText:label,
        hintStyle:hintStyle,
        // new TextStyle(
        //   color: Colors.blue,
        // ),

        border:OutlineInputBorder(

          borderRadius: BorderRadius.circular(30.0),
        ),
        // focusedBorder:OutlineInputBorder(
        //     borderSide: BorderSide(color: Colors.transparent),
        //     borderRadius: BorderRadius.circular(30.0)
        // ),
        // focusedBorder:OutlineInputBorder(

        //   borderSide:
        //   BorderSide(
        //       color: Colors.grey,width: 1),
        // ),

        prefixIcon: Icon(
          prefix,
          color: Colors.black,
        ),

        suffixIcon: Icon(
          suffix,
          color: Colors.black,

        ),


      ),
    ),
  ),
);



//
// Widget defaultformfield({
//   required TextEditingController? controller,
//   required TextInputType  type,
//   String? hintText,
//   required String label,
//   final FormFieldValidator? validate,
//   TextStyle? hintStyle =const TextStyle(
//     color: Colors.transparent,
//   ),
//
//
//   Function(String)? onChanged ,
//   Function(String)? onSubmit ,
//   IconData? suffix,
//   VoidCallback? suffixPressed,
//    IconData? prefix,
//   VoidCallback? onPressedfun,
//   bool obscureText = false,
//
// })=> Material(
// elevation: 0.0,
// borderRadius: BorderRadius.circular(30.0),
// child: Container(
// child:TextFormField(
// controller:controller,
// keyboardType:type,
// onChanged: onChanged,
// onFieldSubmitted:onSubmit,
// onTap: suffixPressed,
// validator: validate,
// obscureText:obscureText,
// style: TextStyle(
// color: Colors.black,
// ),
// cursorColor: Colors.transparent,
//
// decoration: InputDecoration(
// hintText:label,
// hintStyle:hintStyle,
// // new TextStyle(
// //   color: Colors.blue,
// // ),
//
// border:OutlineInputBorder(
//
// borderRadius: BorderRadius.circular(30.0),
// ),
// focusedBorder:OutlineInputBorder(
// borderSide: BorderSide(color: Colors.transparent),
// borderRadius: BorderRadius.circular(30.0)
// ),
// // focusedBorder:OutlineInputBorder(
//
// //   borderSide:
// //   BorderSide(
// //       color: Colors.grey,width: 1),
// // ),
//
// prefixIcon: Icon(
// prefix,
// ),
//
// suffixIcon: Icon(
// suffix,
// ),
// ),
// ),
// ),
// );
