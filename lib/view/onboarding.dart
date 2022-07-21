import 'package:flutter/material.dart';
import 'package:qpdl/models/onboard_model.dart';
import 'package:qpdl/models/first_time.dart';
import 'package:qpdl/utility/basket.dart';
import 'package:qpdl/utility/onboarding_data.dart';
import 'package:qpdl/view/start_page.dart';
import 'package:qpdl/widgets/custom_button.dart';
import 'package:qpdl/widgets/onboarding_widget.dart';
import 'package:qpdl/widgets/round_button.dart';
import 'package:flutter/painting.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  final List<OnBoardModel> _onBoardModel = OnBoardModel.getModels();
  int currentModel = 0;
  final pvController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _onBoardModel =
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
        currentModel = _onBoardModel.length - 1;
        debugPrint("$currentModel");
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
              decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [Colors.black, Colors.black54],)
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top:50, bottom: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TcCircularButton(action: goToPrevPage),
                          TextButton(onPressed: goToLastPage, child: const Text("Skip", style: TextStyle(color:Colors.white))),
                        ],
                      ),

                    ),
                    // const SizedBox(height: 20,width: 20,),

                    SizedBox(
                        height: 400,
                        child: PageView(
                          controller: pvController,
                          onPageChanged: (page){
                            setState(() {
                              currentModel = page;
                            });
                          },
                          children: [
                            for(var i = 0; i < _onBoardModel.length; i++)
                              OnBoardingLayout(data: _onBoardModel[i],),
                          ],

                        )),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for(int i = 0; i < _onBoardModel.length; i++)
                            currentModel == i ?
                            RoundButton(tcColor:basket['SecColor']):
                            RoundButton(tcColor:basket['PrimaryColor']),
                        ]),
                    currentModel == _onBoardModel.length - 1?
                    TcRecButton(child:const Text("Get Started"),action: gotoStartPage ):
                    TcRecButton(child:const Text("Next"),action: goToNextPage )
                  ]
              ),
            )
          ]
        )
      ))




    );
  }
}

