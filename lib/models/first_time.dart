import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';



class FirstTime {

  static Future<bool> is_first_launch() async {
    SharedPreferences _s = await SharedPreferences.getInstance();
    String isFirst = _s.getString('first') ?? "not_first";
    debugPrint(isFirst);
    if(isFirst == "disregard") {
      return false;
    }
    _s.setString('first', "disregard");
    return true;
  }

}