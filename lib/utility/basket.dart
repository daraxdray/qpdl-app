
import 'package:flutter/material.dart';
// 74A236
final Map<String, dynamic> basket = {
  'PrimaryColor': const Color.fromARGB(205, 220,38,38),
  'PrimaryColor2': const Color.fromARGB(255, 139, 0, 0),
  'WhiteColor': const Color.fromARGB(255, 255, 255, 255),
  'GreyColor': const Color.fromARGB(205, 91, 94, 88),
  'SecColor': const Color.fromARGB(205, 245, 64, 64),
  'SecColor2': const Color.fromARGB(255, 162, 54, 54),
  'primaryHex': 0xff8DC63F,
  'colorSwatches': const <int, Color>{
                                    10 : Color(0xFFC63F3F),
                                    50 : Color(0xFFC63F3F),
                                    100 : Color(0xFFC63F3F),
                                    150 : Color(0xFFB62F2F),
                                    200 : Color(0xFFA25050),
                                  },


  'titleText'   : const TextStyle(color: Color.fromARGB(205,68, 68, 68), fontSize: 25, fontWeight: FontWeight.bold,fontFamily: 'BRFirmaBlack' ),
  'WhiteTitle'   : const TextStyle(color: Color.fromARGB(255, 253, 252, 252), fontSize: 25, fontWeight: FontWeight.bold,fontFamily: 'BRFirmaBlack' ),
  'WhiteTitleSm'   : const TextStyle(color: Color.fromARGB(255, 253, 252, 252), fontSize: 16, fontWeight: FontWeight.bold,fontFamily: 'BRFirmaBlack' ),
  'WhiteTitleBg'   : const TextStyle(color: Color.fromARGB(255, 253, 252, 252), fontSize: 30, fontWeight: FontWeight.bold,fontFamily: 'BRFirmaBlack' ),
  'LgTitle'   : const TextStyle(color: Color.fromARGB(205,68, 68, 68), fontSize: 30, fontWeight: FontWeight.bold,fontFamily: 'BRFirmaBlack' ),
  'AppBarTitle'   : const TextStyle(color: Color.fromARGB(205,68, 68, 68), fontSize: 25, fontWeight: FontWeight.bold,fontFamily: 'BRFirmaBlack' ),
  'bodyText'   : const TextStyle(color: Color.fromARGB(205,68, 68, 68), fontSize: 13, fontWeight: FontWeight.normal,fontFamily: 'BRFirmaBlack' ),
  'WhitelabelText'   : const TextStyle(color: Color.fromARGB(205, 255, 255, 255), fontSize: 13, fontWeight: FontWeight.normal,fontFamily: 'BRFirmaBlack' ),
  'WhitelabelTextSm'   : const TextStyle(color: Color.fromARGB(205, 255, 255, 255), fontSize: 8, fontWeight: FontWeight.normal,fontFamily: 'BRFirmaBlack' ),
  'WhitelabelTextBg'   : const TextStyle(color: Color.fromARGB(205, 255, 255, 255), fontSize: 20, fontWeight: FontWeight.normal,fontFamily: 'BRFirmaBlack' ),
  'BlackLabelText'   : const TextStyle(color: Color.fromARGB(255, 28, 26, 26), fontSize: 13, fontWeight: FontWeight.normal,fontFamily: 'BRFirmaBlack' ),



 };


goBack(context){
  return Navigator.pop(context);
}

goTo(context, Widget page){
  return Navigator.push(context, MaterialPageRoute(builder: (context)=> page));
}
goToReplace(context, Widget page){
  return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> page));
}

