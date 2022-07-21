import 'package:qpdl/bloc/menu_bloc.dart';
import 'package:qpdl/view/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:qpdl/utility/basket.dart';
import 'package:qpdl/view/qpdl_webview.dart';
import 'package:qpdl/widgets/custom_button.dart';

class StartPage extends StatelessWidget {
  final MenuBloc _menuBloc = MenuBloc();
  StartPage({Key? key}) : super(key: key);

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

                      gradient: LinearGradient(begin: Alignment.centerRight, colors: [Colors.transparent,Colors.transparent,Colors.orangeAccent,
                        Color.fromARGB(79,59, 34, 8)
                        ,],)
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
              child: const Text("Become a",style: TextStyle(color:Colors.white,fontSize: 50, fontWeight: FontWeight.bold, fontFamily: 'BRFirmaBlack')),
          ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.only(bottom:40,top:0),
                  padding: EdgeInsets.only(top: 0),
                  alignment: Alignment.center,
                  child: Text("QPDL DRIVER",textAlign: TextAlign.center,style:TextStyle(color:basket['PrimaryColor'],fontSize: 45, fontWeight: FontWeight.bold, fontFamily: 'BRFirmaBlack')),
                ),
                Container(
                  width: 300,
                  alignment: Alignment.center,
                  child: Text("Join us to make our customer happier while you earn",textAlign: TextAlign.center, style: basket['WhitelabelTextBg'],),
                ),
                const SizedBox(height: 30,width: 20,),
                TcRecButton(child: Text("Get Started")
                   ,action: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> QpdlWebPage(url: "https://qpdlogistics.com/drivers_register.php?driver_app=true",appBar: true,bloc: _menuBloc,)))),
                const SizedBox(height: 10,width: 20,),
                TcRecButton(child: Text("Login")
                   ,action: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>QpdlWebPage(url: "https://qpdlogistics.com/login.php?driver_app=true",appBar: true, bloc: _menuBloc)))),



              ]
          )
              )
    ])
      ),)
    );
  }
}
