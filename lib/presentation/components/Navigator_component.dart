import 'package:flutter/material.dart';

void  NavigatorTo(context,widget)=> Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context)=>  widget,
    )
);

void  NavigatorandFinish(context,widget)=> Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context)=>  widget,
    ),
        (Route<dynamic>route)=>false
);