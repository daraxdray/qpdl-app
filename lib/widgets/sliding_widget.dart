import 'package:Diagon/models/slide_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Diagon/utility/basket.dart';

class SlidingLayout extends StatelessWidget {
  final SlideModel?  data;
  const SlidingLayout({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(

          width: MediaQuery.of(context).size.width,
          child: Container(
            height: 200,
             width: 100,
             child: SizedBox(),
            decoration:const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomCenter,end: Alignment.center,colors: [Colors.black,Colors.transparent ]),


            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(data?.imagePath ?? 'assets/step1.png',),fit: BoxFit.fill,),
          )
        ),
        // const SizedBox(height: 30,width: 20,),
        // Text(data?.title ?? "",style: basket['WhiteTitleBg']),
        // const SizedBox(height: 10,width: 20,),
        // Container(
        //   height: 60,
        //   width: 300,
        //   alignment: Alignment.center,
        //   child: Text(data?.content ?? "",textAlign: TextAlign.center, style: basket['WhitelabelText'],),
        // )
      ],
    );
  }
}
