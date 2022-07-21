import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qpdl/bloc/menu_bloc.dart';
import 'package:qpdl/bloc/menu_event.dart';
import 'package:qpdl/bloc/menu_state.dart';
import 'package:qpdl/main.dart';
import 'package:qpdl/view/about_us.dart';
import 'package:qpdl/view/dashboard.dart';
import 'package:qpdl/view/qpdl_webview.dart';
import 'package:flutter/material.dart';
import 'package:qpdl/models/first_time.dart';
import 'package:qpdl/utility/basket.dart';
import 'package:qpdl/view/start_page.dart';

import 'package:qpdl/widgets/custom_button.dart';

PreferredSizeWidget trAppBar({Widget? child, Widget? title, context, bool? centerTitle, double? leadingWidth}){
  return AppBar(
      leading: Container(
        padding: const EdgeInsets.all(3),
        margin: const EdgeInsets.only(bottom: 10),
        child: child ?? TcCircularButton(action: ()=> Navigator.pop(context)),
        // Text(title ?? "Williams,", style: basket['AppBarTitle'],),
      ),
      centerTitle: centerTitle,
      title: title,
      leadingWidth: leadingWidth ?? 150,
      backgroundColor: Colors.black87,
      iconTheme:  IconThemeData(
        color: basket['primColor1'], //change your color here
      )
  );
}
PreferredSizeWidget trPageAppBar(context){
  return AppBar(
    leading: Container(
      padding: const EdgeInsets.only(left:15, top: 10),
      child:   TcCircularButton(action: ()=> goBack(context)),),
      leadingWidth: 150,
      iconTheme:  IconThemeData(
        color: basket['PrimaryColor'], //change your color here
      )
  );
}


class TrNavDrawer extends StatelessWidget {
  final MenuBloc bloc;

  const TrNavDrawer({Key? key, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Drawer(
        child: Stack(
          children: [

            TrNavList(bloc:bloc),
             Padding(
              padding: const EdgeInsets.only(left:420,top:140),
              child: Transform.rotate(
                angle: 24.99,
    child:  OverflowBox(
      child: Container(
        child: const MyApp(),
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 9,spreadRadius: 0.5,color: Colors.black26)]
        )
      ),
      maxWidth: 350,
      maxHeight: 550,

    ),)
            )
          ],
        )
      ),
    );
  }
}


class TrNavList extends StatefulWidget {
  MenuBloc bloc;
   TrNavList( {Key? key, required this.bloc}) : super(key: key);

  @override
  _TrNavListState createState() => _TrNavListState();
}

class _TrNavListState extends State<TrNavList> {

  static int activePage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activePage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: widget.bloc,
        builder: (context, state){
      return ListView(
          padding: const EdgeInsets.only(left: 30),
          children: <Widget>[
            DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.asset('assets/favicon.png'),
                        ),
                        Text("QPDL DRIVERS", style: basket['LgTitle'],)
                      ],
                    ),
                    IconButton(icon:Icon(Icons.highlight_remove),color: basket['PrimaryColor'],iconSize: 30, onPressed: () {
                      goBack(context);
                    },)
                  ],
                )
            ),
             ListTile(
              leading: MenuBloc.activeUrl == 0? Container(
                width: 50,
                height: 50,
                child: Icon(Icons.home_outlined,color: basket['WhiteColor'],),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 213, 91, 14),
                ),
              ) :
              Container(
                child: Icon(Icons.home,color: basket['PrimaryColor'],),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(100, 245, 245, 245),
                ),
              ),
              title: Text('Home'),
              onTap: () => {
                setState((){
                  MenuBloc.activeUrl = 0;
                  goTo(context,Dashboard(bloc: widget.bloc,));
                })
              },
            ),
            if(state == LoggedIn) ListTile(
              leading: MenuBloc.activeUrl  == 1? Container(
                width: 50,
                height: 50,
                child: Icon(Icons.dashboard,color: basket['WhiteColor'],),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 213, 91, 14),
                ),
              ) : Container(
                child: Icon(Icons.dashboard,color: basket['PrimaryColor'],),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(100, 245, 245, 245),
                ),
              ) ,

              title: const Text('Dashboard'),
              onTap: (){
                setState((){
                  MenuBloc.activeUrl  = 1;
                  goTo(context,QpdlWebPage(url: "https://qpdlogistics.com/login.php?driver_app=true",appBar: true,));
                });

              },
            ),
            // ListTile(
            //   leading: activePage == 2? Container(
            //     width: 50,
            //     height: 50,
            //     child: Icon(Icons.person_add_alt_1_outlined,color: basket['WhiteColor'],),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(15),
            //       color: Color.fromARGB(255, 213, 91, 14),
            //     ),
            //   ) : Container(
            //     child: Icon(Icons.person_add,color: basket['PrimaryColor'],),
            //     width: 50,
            //     height: 50,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(15),
            //       color: Color.fromARGB(100, 245, 245, 245),
            //     ),
            //   ),
            //   title: Text('Register'),
            //   onTap: () => {
            //     setState((){
            //       activePage = 2;
            //       goTo(context, QpdlWebPage(url: "https://qpdlogistics.com/drivers_register.php?driver_app=true",appBar: true,));
            //     })
            //   },
            // ),
            ListTile(
                leading: MenuBloc.activeUrl == 3? Container(
                  width: 50,
                  height: 50,
                  child: Icon(Icons.location_searching,color: basket['WhiteColor'],),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 213, 91, 14),
                  ),
                ) : Container(
                  child: Icon(Icons.link,color: basket['PrimaryColor'],),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(100, 245, 245, 245),
                  ),
                ),

                title: Text('About Us'),
                onTap: () => {
                  setState((){
                    widget.bloc.add(ActivateMenu(active: 3));
                    goTo(context, AboutPage());
                  })}
            ),
            ListTile(
                leading:  MenuBloc.activeUrl == 4? Container(
                  width: 50,
                  height: 50,
                  child: Icon(Icons.qr_code_scanner,color: basket['WhiteColor'],),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 213, 91, 14),
                  ),
                ) : Container(
                  child: Icon(Icons.gamepad,color: basket['PrimaryColor'],),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(100, 245, 245, 245),
                  ),
                ),
                title:  Text('Tracking'),
                onTap: () {
                  widget.bloc.add(ActivateMenu(active: 4));
                  goTo(context, QpdlWebPage(url:'https://qpdlogistics.com/tracking.php?driver_app=true',appBar: true,));
                }
            ),

            //     ListTile(
            //       leading: activePage == 7? Container(
            // width: 50,
            // height: 50,
            // child: Icon(Icons.history,color: basket['WhiteColor'],),
            // decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(15),
            // color: Color.fromARGB(255, 213, 91, 14),
            // ),
            // ) :  Container(
            //         child: Icon(Icons.history ,color: basket['PrimaryColor'],),
            //         width: 50,
            //         height: 50,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(15),
            //           color: Color.fromARGB(100, 245, 245, 245),
            //         ),
            //       ),
            //       title:  Text('Transaction History'),
            //       onTap: () => {
            //         setState((){
            //           activePage  = 7;
            //         })
            //       },
            //     ),
            //     ListTile(
            //       leading:  activePage == 8? Container(
            // width: 50,
            // height: 50,
            // child: Icon(Icons.settings,color: basket['WhiteColor'],),
            // decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(15),
            // color: Color.fromARGB(255, 213, 91, 14),
            // ),
            // ) : Container(
            //         child: Icon(Icons.settings ,color: basket['PrimaryColor'],),
            //         width: 50,
            //         height: 50,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(15),
            //           color: Color.fromARGB(100, 245, 245, 245),
            //         ),
            //       ),
            //       title:  Text('Settings'),
            //       onTap: () => {
            //         setState((){
            //           activePage = 8;
            //         })
            //       },
            //     ),
            //     ListTile(
            //       leading: activePage == 9? Container(
            //         width: 50,
            //         height: 50,
            //         child: Icon(Icons.logout,color: basket['WhiteColor'],),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(15),
            //           color: Color.fromARGB(255, 213, 91, 14),
            //         ),
            //       ) : Container(
            //         child: Icon(Icons.logout ,color: basket['PrimaryColor'],),
            //         width: 50,
            //         height: 50,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(15),
            //           color: Color.fromARGB(100, 245, 245, 245),
            //         ),
            //       ),
            //       title:  Text('Logout'),
            //       onTap: () => {
            //         setState((){
            //           activePage = 9;
            //         })
            //       },
            // )
          ]);
    });
  }
}
