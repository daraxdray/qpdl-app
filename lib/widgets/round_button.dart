import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final Color? tcColor;
  const RoundButton({Key? key, this.tcColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      margin:const EdgeInsets.all(15),
      decoration:  BoxDecoration(
        shape: BoxShape.circle,
        color: tcColor
      ),
    );
  }
}
