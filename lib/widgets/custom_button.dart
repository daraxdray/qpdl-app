import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qpdl/utility/basket.dart';


class TcCircularButton extends StatelessWidget {
   dynamic action;
  final Icon? icon;
  final Color? bgColor;
  TcCircularButton({Key? key, this.action, this.icon, this.bgColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        child: icon ?? const Icon(Icons.arrow_back),
        onPressed: action,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          primary: bgColor ?? basket['PrimaryColor'],
          elevation: 15.0
        ),
    ));
  }
}


class TcRecButton extends StatelessWidget {
  final Widget? child;
  final dynamic action;
  final double? tcWidth;
  final MaterialStateProperty? bgColor;
  const TcRecButton({Key? key, this.child, required this.action, this.tcWidth, this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: tcWidth ?? 200,
      child: ElevatedButton(
        onPressed: () => action() , child: child ?? const Text("Button"),
        style: ButtonStyle(backgroundColor: bgColor ?? basket['PrimaryBasket'],
        elevation: MaterialStateProperty.all(15)),
      ),

    );
  }
}

class TcElipsButton extends StatelessWidget {
  final Widget? child;
  final dynamic action;
  final double? tcWidth;
  final Color? bgColor;
  const TcElipsButton({Key? key, this.child, required this.action, this.tcWidth, this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: tcWidth ?? 200,
      child: ElevatedButton(
        onPressed: () => action() , child: child ?? const Text("Button"),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(bgColor ?? basket['PrimaryBasket']),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(side: BorderSide.none,borderRadius: BorderRadius.circular(20)),),

        elevation: MaterialStateProperty.all(15)),

      ),

    );
  }
}

dynamic isHere;