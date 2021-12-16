import 'package:Diagon/models/slide_model.dart';
import 'package:Diagon/utility/onboarding_data.dart';
import 'package:Diagon/view/start_page.dart';
import 'package:Diagon/widgets/custom_button.dart';
import 'package:Diagon/widgets/round_button.dart';
import 'package:Diagon/widgets/sliding_widget.dart';
import 'package:flutter/material.dart';
import 'package:Diagon/models/first_time.dart';
import 'package:Diagon/utility/basket.dart';
import 'package:Diagon/widgets/tr_appbar.dart';

import 'Diagon_webview.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: TrNavDrawer(),
      drawerEnableOpenDragGesture: false,
      appBar: trAppBar(

      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        child:  Container(
          // height: MediaQuery.of(context).size.width,
          child: Stack(
              children: [
                const SlidingScreen(),
                Container(
                  color: Colors.black,
                  child: Image.asset('assets/collage.png'),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        // gradient: LinearGradient(begin: Alignment.bottomRight,  colors: [Colors.black, Colors.black,Colors.black54], end: Alignment.topCenter)
                      color: Color.fromARGB(230, 0, 0, 0)
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SlidingScreen(),
                          const SizedBox(height: 10,width: 20,),
                          SizedBox(
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
                                        for(int i = 0; i < gameList.length - 1; i++ )
                                        InkWell(
                                          onTap: ()=>{
                                            goTo(context, DiagonWebPage(url: gameList[i]['url'] ?? "https://Diagon.io/perfect-piano",))
                                          },
                                            child: Container(
                                                padding: const EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  image:  DecorationImage(image: AssetImage("${gameList[i]['imagePath']}")),
                                                ))
                                        ),


                                      ],
                                    ),
                                  ),
                                ],
                              )
                          )

                        ]
                    )
                )
              ])
        )

      ),
    );
  }
}

class Company {
}



class SlidingScreen extends StatefulWidget {
  const SlidingScreen({Key? key}) : super(key: key);

  @override
  _SlidingScreenState createState() => _SlidingScreenState();
}

class _SlidingScreenState extends State<SlidingScreen> {

  final List<SlideModel> _slideModel = SlideModel.getModels();
  int currentModel = 0;
  final pvController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _slideModel =
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

  gotoStartPage(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const StartPage()));
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

                  ]
              );

  }
}

