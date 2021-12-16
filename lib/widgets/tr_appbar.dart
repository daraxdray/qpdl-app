import 'package:Diagon/main.dart';
import 'package:Diagon/view/dashboard.dart';
import 'package:Diagon/view/Diagon_webview.dart';
import 'package:flutter/material.dart';
import 'package:Diagon/models/first_time.dart';
import 'package:Diagon/utility/basket.dart';

import 'package:Diagon/widgets/custom_button.dart';

PreferredSizeWidget trAppBar(){
  return AppBar(
    leading: Container(
      padding: const EdgeInsets.only(left:15, top: 20),
      child: Text("Gameboard", style: TextStyle(color: Colors.white,fontFamily: 'BRFirmaBlack',fontSize: 16),),
    ),
      leadingWidth: 150,
      iconTheme:  IconThemeData(
        color: basket['WhiteColor'], //change your color here
      ),
    backgroundColor: const Color.fromARGB(221, 125, 8, 8),
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
  const TrNavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Drawer(
        child: Stack(
          children: [

            TrNavList(),
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
  const TrNavList({Key? key}) : super(key: key);

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
                    Text("Diagon", style: basket['LgTitle'],)
                  ],
                ),
                IconButton(icon:Icon(Icons.highlight_remove),color: basket['PrimaryColor'],iconSize: 30, onPressed: () {
                  goBack(context);
                },)
              ],
            )
        ),
        ListTile(
          leading: activePage == 0? Container(
            width: 50,
            height: 50,
            child: Icon(Icons.home_outlined,color: basket['WhiteColor'],),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(255, 162, 54, 54),
            ),
          ) :
        Container(
            child: Icon(Icons.delete_outline_rounded,color: basket['PrimaryColor'],),
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
              activePage = 0;
              goTo(context,Dashboard());
             })
          },
        ),
        ListTile(
          leading: activePage == 1? Container(
            width: 50,
            height: 50,
            child: Icon(Icons.delete_outline_rounded,color: basket['WhiteColor'],),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(255, 162, 54, 54),
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

          title: Text('Dashboard'),
          onTap: (){
            setState((){
              activePage = 1;
              goTo(context,DiagonWebPage(url:'https://Diagon.io/dashboard'));
            });

          },
        ),
        ListTile(
          leading: activePage == 2? Container(
            width: 50,
            height: 50,
            child: Icon(Icons.calculate_outlined,color: basket['WhiteColor'],),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(255, 162, 54, 54),
            ),
          ) : Container(
            child: Icon(Icons.calculate_outlined,color: basket['PrimaryColor'],),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(100, 245, 245, 245),
            ),
          ),
          title: Text('Transactions'),
          onTap: () => {
            setState((){
              activePage = 2;
              goTo(context, DiagonWebPage(url:'https://Diagon.io/transactions'));
            })
          },
        ),
        ListTile(
          leading:activePage == 3? Container(
            width: 50,
            height: 50,
            child: Icon(Icons.location_searching,color: basket['WhiteColor'],),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 162, 54, 54),
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

          title: Text('Invite Friends'),
          onTap: () => {
            setState((){
            activePage = 3;
            goTo(context, DiagonWebPage(url:'https://Diagon.io/affiliate'));
          })}
        ),
        ListTile(
          leading:  activePage == 4? Container(
          width: 50,
          height: 50,
          child: Icon(Icons.qr_code_scanner,color: basket['WhiteColor'],),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(255, 162, 54, 54),
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
          title:  Text('Diagon Games'),
          onTap: () {
            activePage =4;
            goTo(context, DiagonWebPage(url:'https://Diagon.io/games'));
          }
        ),
        ListTile(
          leading: activePage == 5? Container(
            width: 50,
            height: 50,
            child: Icon(Icons.location_on_outlined,color: basket['WhiteColor'],),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(255, 162, 54, 54),
            ),
          ) : Container(
            child: Icon(Icons.add_moderator,color: basket['PrimaryColor'],),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(100, 245, 245, 245),
            ),
          ),
          title:  Text('Diagon Utility'),
          onTap: () => {
            setState((){
              activePage = 5;
              goTo(context, DiagonWebPage(url:'https://Diagon.io/utility'));
            })
          },
        ),
        ListTile(
          leading: activePage == 6? Container(
            width: 50,
            height: 50,
            child: Icon(Icons.swap_vert_circle_outlined,color: basket['WhiteColor'],),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(255, 162, 54, 54),
            ),
          ) : Container(
            child: Icon(Icons.swap_vert_circle_outlined ,color: basket['PrimaryColor'],),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(100, 245, 245, 245),
            ),
          ),
          title:  Text('Diagon NFT'),
          onTap: () => {
            setState((){
            activePage = 6;
            goTo(context, DiagonWebPage(url:'https://Diagon.io/nft'));
          }) }
        ),
    //     ListTile(
    //       leading: activePage == 7? Container(
    // width: 50,
    // height: 50,
    // child: Icon(Icons.history,color: basket['WhiteColor'],),
    // decoration: BoxDecoration(
    // borderRadius: BorderRadius.circular(15),
    // color: Color.fromARGB(255, 162, 54, 54),
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
    // color: Color.fromARGB(255, 162, 54, 54),
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
    //           color: Color.fromARGB(255, 162, 54, 54),
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
  }
}
