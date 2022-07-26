import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qpdl/models/onboard_model.dart';
import 'package:qpdl/utility/basket.dart';

class OnBoardingLayout extends StatelessWidget {
  final OnBoardModel?  data;
  const OnBoardingLayout({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          color: Colors.white,
          height: 260,
          width: MediaQuery.of(context).size.width ,
          child: Image.asset(data?.imagePath ?? 'assets/step1.png'),
        ),
        const SizedBox(height: 30,width: 20,),
        Text(data?.title ?? "The title of the on-boarding",style: basket['WhiteTitleBg']),
        const SizedBox(height: 10,width: 20,),
        Container(
          height: 60,
          width: 300,
          alignment: Alignment.center,
          child: Text(data?.content ?? "The content of the on-boarding should be here",textAlign: TextAlign.center, style: basket['WhitelabelText'],),
        )
      ],
    );
  }
}
