import 'dart:async';

import 'package:qpdl/bloc/menu_bloc.dart';
import 'package:qpdl/models/slide_model.dart';
import 'package:qpdl/utility/onboarding_data.dart';
import 'package:qpdl/view/about_us.dart';
import 'package:qpdl/view/start_page.dart';
import 'package:qpdl/widgets/custom_button.dart';
import 'package:qpdl/widgets/round_button.dart';
import 'package:qpdl/widgets/sliding_widget.dart';
import 'package:flutter/material.dart';
import 'package:qpdl/models/first_time.dart';
import 'package:qpdl/utility/basket.dart';
import 'package:qpdl/widgets/tr_appbar.dart';

import 'qpdl_webview.dart';

class Dashboard extends StatelessWidget {
  MenuBloc? bloc;
  Dashboard({Key? key,  this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: TrNavDrawer(bloc: bloc ?? MenuBloc(),),
      drawerEnableOpenDragGesture: false,
      appBar: trAppBar(title: Text("Home"),leadingWidth: 50,child:SizedBox()),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        child:  Column(
          children: [
            SizedBox(
                height: 600,
                child:  CustomScrollView(
                  primary: false,
                  shrinkWrap: true,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.all(25),
                      sliver: SliverGrid.count(
                        crossAxisSpacing: 40,
                        mainAxisSpacing: 40,
                        crossAxisCount: 2,
                        children: <Widget>[
                          InkWell(
                            onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> QpdlWebPage(url: "https://qpdlogistics.com/login.php?driver_app=true",appBar: true,bloc: bloc,))),
                            child: Container(
                                padding: const EdgeInsets.all(10),

                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                      SizedBox(
                                          height: 60,
                                          child:  Icon(Icons.home_outlined,color: basket['PrimaryColor'],size: 40,),
                                      ),
                                      SizedBox(
                                          child:
                                          Text("Dashboard", style: TextStyle(color:Colors.black87,fontSize: 16,fontWeight: FontWeight.bold,),))
                                    ]
                                ),
                                decoration: BoxDecoration(
                                  color:  Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [BoxShadow(color: Colors.black26,offset: Offset(-2, 4),blurRadius: 2)],
                                )
                            ),
                          ),
                          InkWell(
                            onTap: ()=> goTo(context, QpdlWebPage(url:'https://qpdlogistics.com/tracking.php?driver_app=true',appBar: true,)),
                            child: Container(
                                padding: const EdgeInsets.all(10),

                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                      SizedBox(
                                          height: 60,
                                          child:  Icon(Icons.gamepad,color: basket['PrimaryColor'],size: 40,),
                                      ),
                                      SizedBox(
                                          child:
                                          Text("Tracking", style: TextStyle(color:Colors.black87,fontSize: 16,fontWeight: FontWeight.bold,),))
                                    ]
                                ),
                                decoration: BoxDecoration(
                                  color:  Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [BoxShadow(color: Colors.black26,offset: Offset(-2, 4),blurRadius: 2)],
                                )
                            ),
                          ),
                          InkWell(
                            onTap: ()=> goTo(context, QpdlWebPage(url:'https://qpdlogistics.com/pickup_list.php?driver_app=true',appBar: false,)),
                            child: Container(
                                padding: const EdgeInsets.all(10),

                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                      SizedBox(
                                          height: 60,
                                          child:  Icon(Icons.shopping_cart,color: basket['PrimaryColor'],size: 40,),
                                      ),
                                      SizedBox(
                                          child:
                                          Text("Pickup List", style: TextStyle(color:Colors.black87,fontSize: 16,fontWeight: FontWeight.bold,),))
                                    ]
                                ),
                                decoration: BoxDecoration(
                                  color:  Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [BoxShadow(color: Colors.black26,offset: Offset(-2, 4),blurRadius: 2)],
                                )
                            ),
                          ),
                          InkWell(
                            onTap: ()=> goTo(context, QpdlWebPage(url:'https://qpdlogistics.com/reports.php?driver_app=true',appBar: false,)),
                            child: Container(
                                padding: const EdgeInsets.all(10),

                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                      SizedBox(
                                          height: 60,
                                          child:  Icon(Icons.report,color: basket['PrimaryColor'],size: 40,),
                                      ),
                                      SizedBox(
                                          child:
                                          Text("General Reports", style: TextStyle(color:Colors.black87,fontSize: 16,fontWeight: FontWeight.bold,),))
                                    ]
                                ),
                                decoration: BoxDecoration(
                                  color:  Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [BoxShadow(color: Colors.black26,offset: Offset(-2, 4),blurRadius: 2)],
                                )
                            ),
                          ),
                          InkWell(
                            onTap: ()=> goTo(context, AboutPage(bloc: bloc,)),
                            child: Container(
                                padding: const EdgeInsets.all(10),

                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                      SizedBox(
                                          height: 60,
                                          child:  Icon(Icons.link,color: basket['PrimaryColor'],size: 40,),
                                      ),
                                      SizedBox(
                                          child:
                                          Text("About Us", style: TextStyle(color:Colors.black87,fontSize: 16,fontWeight: FontWeight.bold,),))
                                    ]
                                ),
                                decoration: BoxDecoration(
                                  color:  Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [BoxShadow(color: Colors.black26,offset: Offset(-2, 4),blurRadius: 2)],
                                )
                            ),
                          ),



                        ],
                      ),
                    ),
                  ],
                )
            )
          ],
        )

      ),
    );
  }
}



class SlidingScreen extends StatefulWidget {
  final bool autorotate;


   const SlidingScreen({Key? key, this.autorotate= true} ) : super(key: key);

  @override
  _SlidingScreenState createState() => _SlidingScreenState();
}

class _SlidingScreenState extends State<SlidingScreen> {

  final List<SlideModel> _slideModel = SlideModel.getModels();
  int currentModel = 0;
  final pvController = PageController();
  Timer? _timer;
  void autoRotate(){
    const interval = Duration(seconds: 2);
    if(widget.autorotate){
      _timer = Timer.periodic(
         interval,
        (Timer timer){
           if(currentModel < _slideModel.length - 1) {
             goToNextPage();
           } else{
             goToFirstPage();
           }
          }
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer!.cancel();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _slideModel =
    autoRotate();
  }

  goToNextPage(){

    setState(() {
      currentModel++;
      debugPrint("$currentModel");
    });
    animateToPage();
  }

  goToPrevPage(){

    setState(() {
      currentModel--;
      debugPrint("$currentModel");
      // pvController.nextPage(duration: const Duration(seconds: 1), curve: CurveTween(curve: Curves.bounceIn).curve);
    });
    animateToPage();
  }
  goToLastPage(){
    setState(() {
      currentModel = _slideModel.length - 1;
      debugPrint("$currentModel");
    });
    animateToPage();
  }
  goToFirstPage(){
    setState(() {
      currentModel = 0;
    });
    animateToPage();
  }

  gotoStartPage(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => StartPage()));
  }
  animateToPage(){
    if (pvController.hasClients) {
      pvController.animateToPage(currentModel, duration:const Duration(microseconds: 10000), curve: CurveTween(curve: Curves.bounceIn).curve);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                        child: PageView(
                          controller: pvController,
                          onPageChanged: (page){
                            setState(() {
                              currentModel = page;
                            });
                          },
                          children: [
                            for(var i = 0; i < _slideModel.length; i++)
                              SlidingLayout(data: _slideModel[i],),
                          ],

                        )),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for(int i = 0; i < _slideModel.length; i++)
                            currentModel == i ?
                            RoundButton(tcColor:basket['PrimaryColor']):
                            RoundButton(tcColor:basket['WhiteColor']),
                        ]),
                    TcRecButton(child:const Text("Play Game", style: TextStyle(fontFamily: 'BRFirmaBlack')),action: gotoStartPage,  )

                          ],
                        );

  }
}

