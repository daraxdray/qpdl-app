import 'package:qpdl/bloc/menu_bloc.dart';
import 'package:qpdl/view/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:qpdl/utility/basket.dart';
import 'package:qpdl/view/qpdl_webview.dart';
import 'package:qpdl/widgets/custom_button.dart';
import 'package:qpdl/widgets/tr_appbar.dart';

class AboutPage extends StatelessWidget {
  MenuBloc? bloc;

  AboutPage({Key? key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: TrNavDrawer(bloc: bloc ?? MenuBloc(),),
      drawerEnableOpenDragGesture: false,
      appBar: trAppBar(),
      body:Container(
            alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
    color: Colors.white,
    child: Text("QPD Logistics is an international freight forwarding company. We provide logistics solutions to meet the ever growing needs of supply chains within, to and from the African continent. At QPD, we do more than just logistics. Our team members can help solve any challenge in Logistics to ensure your supply chains remain resilient. Our network spans the entire globe to ensure your needs are adequately met.",
    style: TextStyle(fontSize: 20,letterSpacing: 1.0,wordSpacing: 2),)
      ),);
  }
}
