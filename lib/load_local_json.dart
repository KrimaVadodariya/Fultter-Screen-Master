import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalJesonParsing extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    rootBundle.loadString('assets/json/localjson.json');

    return Scaffold();
  }

}