import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qpdl/view/dashboard.dart';
import 'package:qpdl/view/onboarding.dart';
import 'package:qpdl/view/qpdl_webview.dart';
import 'package:qpdl/view/start_page.dart';
import 'package:flutter/material.dart';
import 'package:qpdl/models/first_time.dart';
import 'package:qpdl/utility/basket.dart';

import 'bloc/menu_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  await Permission.microphone.request();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'QPDL',
        theme: ThemeData(
          primaryColor: MaterialColor(basket['primaryHex'], basket['colorSwatches']),
          primaryColorBrightness: Brightness.light,
          primaryColorDark: const Color.fromARGB(220,220,38,38),
          appBarTheme: AppBarTheme(
            color: Color.fromARGB(247, 239, 239, 238),
            elevation: 0,
          ),
          iconTheme: IconThemeData(
              color: basket['PrimaryColor']
          ),
          splashColor: basket['PrimaryColor'],
          elevatedButtonTheme:  ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  primary: basket['PrimaryColor'], // background color
                  textStyle: const TextStyle(fontSize: 20, fontStyle: FontStyle.normal))),
          textTheme: TextTheme(bodyText1: basket['bodyText'],),
          textButtonTheme: TextButtonThemeData(style:TextButton.styleFrom()),
          inputDecorationTheme: InputDecorationTheme(
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: basket['PrimaryColor'])
              )
          ),

        ),
        home:FutureBuilder(
        future: FirstTime.is_first_launch(),
        builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {

          if(snapshot.hasData && snapshot.data == false){
            return StartPage();
          }
          else if(snapshot.hasData && snapshot.data == true){
            return const OnBoardingScreen();

          }

          if(snapshot.hasError){
            return Scaffold(
              body: Center(
                  child: Text("Error...",style: basket['BlackLabelText'])
              ),
            );
          }
          return Scaffold(
            body: Center(
                child: Text("Loading...",style: basket['BlackLabelText'])
            ),
          );

        },

      ),
    );
  }
}

