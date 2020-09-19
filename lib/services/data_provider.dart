// DataProvider (ChangeNotifier)
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
 
  DataProvider() {}
 
  void incrementCount(){
    _count++;
    notifyListeners();
  }
}
 