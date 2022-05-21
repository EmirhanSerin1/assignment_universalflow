import 'package:flutter/material.dart';

class Translar with ChangeNotifier{
  List _list = []; 

  get list => _list;

  void setList(List list){
    _list = list;
    notifyListeners();
  }

}