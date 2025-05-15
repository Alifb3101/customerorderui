import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uiordertask/data/%20orders_sample.dart';
import 'screens/ orders_dashboard.dart';

void main(){
  runApp(myapp());
}
class myapp extends StatefulWidget {
  const myapp({super.key});

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
      home: CustomerPage(),
    );
  }
}
