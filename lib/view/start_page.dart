import 'package:Diagon/view/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:Diagon/utility/basket.dart';
import 'package:Diagon/widgets/custom_button.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height,
    color: Colors.black,
    child: Stack(
    children: [
    Container(
    color: Colors.black,
    child: Image.asset('assets/collage.png'),
    ),
      Container(
        width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.bottomRight, colors: [Colors.black, Colors.black,Colors.black,Colors.black54,],)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 300,width: 20,),
          Container(
              width: 300,
              margin: const EdgeInsets.only(bottom:0,top:10),
              padding: const EdgeInsets.only(top: 0),
              alignment: Alignment.center,
              child: const Text("Casually",style: TextStyle(color:Colors.white,fontSize: 50, fontWeight: FontWeight.bold, fontFamily: 'BRFirmaBlack')),
          ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.only(bottom:40,top:0),
                  padding: EdgeInsets.only(top: 0),
                  alignment: Alignment.center,
                  child: const Text("PlayToEarn",textAlign: TextAlign.center,style:TextStyle(color:Colors.red,fontSize: 45, fontWeight: FontWeight.bold, fontFamily: 'BRFirmaBlack')),
                ),
                Container(
                  width: 300,
                  alignment: Alignment.center,
                  child: Text("The platform that gives you the best living experience with crypto",textAlign: TextAlign.center, style: basket['WhitelabelTextBg'],),
                ),
                const SizedBox(height: 30,width: 20,),
                TcRecButton(child: Text("Get Started")
                   ,action: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  const Dashboard())),tcWidth: 250,),
                const SizedBox(height: 10,width: 20,),


              ]
          )
              )
    ])
      ),)
    );
  }
}
