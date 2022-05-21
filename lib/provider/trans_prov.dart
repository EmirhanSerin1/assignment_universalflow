import 'package:flutter/material.dart';

class TransactionProvider with ChangeNotifier{
  List _list = []; 
  List _datas =[];

  get list => _list;
  get datas=>_datas;

  void setList(List list){
    _list = list;
    notifyListeners();
  }

  void setdata(List data){
    _datas = data;
    notifyListeners();
  }

}