import 'auth.dart';
import 'loginscreen.dart';
import 'class_list.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) :super(key:key);
  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}
class _WidgetTreeState extends State<WidgetTree>{
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: Auth().authStateChanges,builder:(context,snapshot) {
      if(snapshot.hasData) {
        return ClassList(title: "Your class info:");
      } else {
        return LoginScreen(title: "Please log in:");
      }
    });
  }
}