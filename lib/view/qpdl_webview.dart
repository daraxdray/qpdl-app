import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qpdl/bloc/menu_bloc.dart';
import 'package:qpdl/bloc/menu_event.dart';
import 'package:qpdl/utility/basket.dart';
import 'package:qpdl/view/dashboard.dart';
import 'package:qpdl/view/start_page.dart';
import 'package:qpdl/widgets/tr_appbar.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QpdlWebPage extends StatefulWidget {
  final url;
  bool? appBar;
  MenuBloc? bloc;
  QpdlWebPage({Key? key, this.url="https://qpdlogistics.com", this.appBar , this.bloc}) : super(key: key);

  @override
  _QpdlWebPageState createState() =>
      new _QpdlWebPageState();
}

class _QpdlWebPageState extends State<QpdlWebPage> {

  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  late ContextMenu contextMenu;
  String url = "https://qpdlogistics.com/login.php?driver_app=true";
  double progress = 0;
  bool?  showErrorPage, noConnection = false;
  final urlController = TextEditingController();
  DateTime currentBackPressTime= DateTime.now();
  @override
  void initState() {
    super.initState();
    showErrorPage = false;
    noConnection = false;
    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              androidId: 1,
              iosId: "1",
              title: "Special",
              action: () async {
                print("Menu item Special clicked!");
                print(await webViewController?.getSelectedText());
                await webViewController?.clearFocus();
              })
        ],
        options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {
          // print("onCreateContextMenu");
          // print(hitTestResult.extra);
          // print(await webViewController?.getSelectedText());
        },
        onHideContextMenu: () {
          // print("onHideContextMenu");
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = (Platform.isAndroid)
              ? contextMenuItemClicked.androidId
              : contextMenuItemClicked.iosId;
          // print("onContextMenuActionItemClicked: " +
          //     id.toString() +
          //     " " +
          //     contextMenuItemClicked.title);
        });

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
  void showError() {
    setState(() {
      showErrorPage = true;
    });
  }

  login(){
    widget.bloc?.add(LogInEvent());
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop:  () async {
          DateTime now = DateTime.now();
          if (currentBackPressTime == null ||
              now.difference(currentBackPressTime) > Duration(seconds: 2)) {
            currentBackPressTime = now;
            Fluttertoast.showToast(
              msg: 'Press Back Once Again to Go Home.',
              backgroundColor: Colors.black,
              textColor: Colors.white,
            );
            return false;
          }
          goTo(context, Dashboard(bloc: widget.bloc,));
          return true;
        },
        child: widget.appBar != null?
      Scaffold(
        appBar: AppBar(
           title: const Text("Qpdl: Delivery Made Easy", style: TextStyle(fontSize: 16)),
        leading: TextButton(
          child: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if(webViewController?.canGoBack() == true) webViewController?.goBack();
            else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    new StartPage()));
            }
          },
        ),
          iconTheme:  IconThemeData(
            color: Colors.white, //change your color here
          ),
        backgroundColor: Colors.black87,
        ),
        endDrawer:  TrNavDrawer(bloc: widget.bloc ?? MenuBloc()),
        body: SafeArea (
            child: Column(children: <Widget>[
              // TextField(
              //   decoration: InputDecoration(
              //       prefixIcon: Icon(Icons.search)
              //   ),
              //   controller: urlController,
              //   keyboardType: TextInputType.url,
              //   onSubmitted: (value) {
              //     var url = Uri.parse(value);
              //     if (url.scheme.isEmpty) {
              //       url = Uri.parse("https://www.google.com/search?q=" + value);
              //     }
              //     webViewController?.loadUrl(
              //         urlRequest: URLRequest(url: url));
              //   },
              // ),
              Expanded(
                child: Stack(
                  children: [
                    InAppWebView(
                      key: webViewKey,
                      // contextMenu: contextMenu,
                      initialUrlRequest:
                      URLRequest(url: Uri.parse(widget.url)),
                      // initialFile: "assets/index.html",
                      initialUserScripts: UnmodifiableListView<UserScript>([]),
                      initialOptions: options,
                      pullToRefreshController: pullToRefreshController,
                      onWebViewCreated: (controller) {
                        webViewController = controller;

                      },
                      onLoadStart: (controller, url) {

                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                          debugPrint(this.url.endsWith("index.php").toString());
                          if(this.url.endsWith("index.php")){
                            widget.appBar = null;
                          }
                        });
                      },
                      androidOnPermissionRequest: (controller, origin, resources) async {
                        return PermissionRequestResponse(
                            resources: resources,
                            action: PermissionRequestResponseAction.GRANT);
                      },
                      shouldOverrideUrlLoading: (controller, navigationAction) async {
                        var uri = navigationAction.request.url!;

                        if (![
                          "http",
                          "https",
                          "file",
                          "chrome",
                          "data",
                          "javascript",
                          "about"
                        ].contains(uri.scheme)) {
                          if (await canLaunch(url)) {
                            // Launch the App
                            await launch(
                              url,
                            );
                            // and cancel the request
                            return NavigationActionPolicy.CANCEL;
                          }
                        }

                        return NavigationActionPolicy.ALLOW;
                      },
                      onLoadStop: (controller, url) async {
                        pullToRefreshController.endRefreshing();
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                          if(this.url.endsWith("index.php")) login();
                        });
                      },
                      onLoadError: (controller, url, i, s) {
                        pullToRefreshController.endRefreshing();
                        if(i == -1009 || i == -2){
                          setState(() {
                            noConnection = true;
                          });
                          Fluttertoast.showToast(msg:s,backgroundColor: Colors.red,gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG);
                        }else{
                          /** instead of printing the console message i want to render a static page or display static message **/
                          Fluttertoast.showToast(msg:s,backgroundColor: Colors.red,gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG);
                          showError();
                        }
                      },
                      onProgressChanged: (controller, progress) {
                        if (progress == 100) {
                          pullToRefreshController.endRefreshing();
                        }
                        setState(() {
                          this.progress = progress / 100;
                          urlController.text = this.url;
                        });
                      },

                      onUpdateVisitedHistory: (controller, url, androidIsReload) {
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      onConsoleMessage: (controller, consoleMessage) {
                        print(consoleMessage);
                      },
                    ),
                    progress < 1.0
                        ? LinearProgressIndicator(value: progress)
                        : Container(),
                    showErrorPage == true
                        ? Center(
                        child: Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Image.asset('assets/img/not_found.png'),
                                TextButton.icon(
                                    onPressed: () =>  webViewController?.goBack(),
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.black38,
                                    ),
                                    label: Text(
                                      "Go Back",
                                      style: TextStyle(
                                          color: Colors.black38,
                                          fontSize: 20),
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                    child: TextButton.icon(
                                        onPressed: () =>
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                    new Dashboard(bloc: widget.bloc,))),
                                        icon: Icon(
                                          Icons.home_outlined,
                                          color: Colors.black38,
                                          size: 12,
                                        ),
                                        label: Text(
                                          "Dashboard",
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 12),
                                        )))
                              ],
                            )))
                        : Container(),
                    noConnection == true
                        ? Center(
                        child: Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/no_connection.png'),
                                SizedBox(
                                  height: 20,
                                ),
                                TextButton.icon(
                                    onPressed: () =>
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                new Dashboard(bloc: widget.bloc,))),
                                    icon: Icon(
                                      Icons.home_outlined,
                                      color: Colors.black38,
                                      size: 12,
                                    ),
                                    label: Text(
                                      "Dashboard",
                                      style: TextStyle(
                                          color: Colors.black38,
                                          fontSize: 12),
                                    ))
                              ],
                            )))
                        : Container(),

                  ],

                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[

                  // ElevatedButton(
                  //   child: Icon(Icons.arrow_forward),
                  //   onPressed: () {
                  //     webViewController?.goForward();
                  //   },
                  // ),
                  // ElevatedButton(
                  //   child: Icon(Icons.refresh),
                  //   onPressed: () {
                  //     webViewController?.reload();
                  //   },
                  // ),
                ],
              ),
            ]))):
       Scaffold(body: SafeArea (
            child: Column(children: <Widget>[
              // TextField(
              //   decoration: InputDecoration(
              //       prefixIcon: Icon(Icons.search)
              //   ),
              //   controller: urlController,
              //   keyboardType: TextInputType.url,
              //   onSubmitted: (value) {
              //     var url = Uri.parse(value);
              //     if (url.scheme.isEmpty) {
              //       url = Uri.parse("https://www.google.com/search?q=" + value);
              //     }
              //     webViewController?.loadUrl(
              //         urlRequest: URLRequest(url: url));
              //   },
              // ),
              Expanded(
                child: Stack(
                  children: [
                    InAppWebView(
                      key: webViewKey,
                      // contextMenu: contextMenu,
                      initialUrlRequest:
                      URLRequest(url: Uri.parse(widget.url)),
                      // initialFile: "assets/index.html",
                      initialUserScripts: UnmodifiableListView<UserScript>([]),
                      initialOptions: options,
                      pullToRefreshController: pullToRefreshController,
                      onWebViewCreated: (controller) {
                        webViewController = controller;

                      },
                      onLoadStart: (controller, url) {
                        // widget.bloc?.isLoggedIn();
                        setState(() {
                          this.url = url.toString();
                          if(this.url.contains("dashboard")){
                            widget.appBar = false;
                          }
                          urlController.text = this.url;
                        });
                      },
                      androidOnPermissionRequest: (controller, origin, resources) async {
                        return PermissionRequestResponse(
                            resources: resources,
                            action: PermissionRequestResponseAction.GRANT);
                      },
                      shouldOverrideUrlLoading: (controller, navigationAction) async {
                        var uri = navigationAction.request.url!;

                        if (![
                          "http",
                          "https",
                          "file",
                          "chrome",
                          "data",
                          "javascript",
                          "about"
                        ].contains(uri.scheme)) {
                          if (await canLaunch(url)) {
                            // Launch the App
                            await launch(
                              url,
                            );
                            // and cancel the request
                            return NavigationActionPolicy.CANCEL;
                          }
                        }

                        return NavigationActionPolicy.ALLOW;
                      },
                      onLoadStop: (controller, url) async {
                        pullToRefreshController.endRefreshing();
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                          if(this.url.endsWith("index.php")) login();
                        });
                      },
                      onLoadError: (controller, url, i, s) {
                        pullToRefreshController.endRefreshing();
                        if(i == -1009 || i == -2){
                          setState(() {
                            noConnection = true;
                          });
                          Fluttertoast.showToast(msg:s,backgroundColor: Colors.red,gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG);
                        }else{
                          /** instead of printing the console message i want to render a static page or display static message **/
                          Fluttertoast.showToast(msg:s,backgroundColor: Colors.red,gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG);
                          showError();
                        }
                      },
                      onProgressChanged: (controller, progress) {
                        if (progress == 100) {
                          pullToRefreshController.endRefreshing();
                        }
                        setState(() {
                          this.progress = progress / 100;
                          urlController.text = this.url;
                        });
                      },
                      onUpdateVisitedHistory: (controller, url, androidIsReload) {
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      onConsoleMessage: (controller, consoleMessage) {
                        print(consoleMessage);
                      },
                    ),
                    progress < 1.0
                        ? LinearProgressIndicator(value: progress)
                        : Container(),
                    showErrorPage == true
                        ? Center(
                        child: Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Image.asset('assets/not_found.png'),
                                SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                    child: TextButton.icon(
                                        onPressed: () =>
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                    new StartPage())),
                                        icon: Icon(
                                          Icons.home_outlined,
                                          color: Colors.black38,
                                          size: 12,
                                        ),
                                        label: Text(
                                          "Home",
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 12),
                                        )))
                              ],
                            )))
                        : Container(),
                    noConnection == true
                        ? Center(
                        child: Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/no_connection.png'),
                                SizedBox(
                                  height: 20,
                                ),
                                TextButton.icon(
                                    onPressed: () =>
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                Dashboard(bloc:widget.bloc))),
                                    icon: Icon(
                                      Icons.home_outlined,
                                      color: Colors.black38,
                                      size: 12,
                                    ),
                                    label: Text(
                                      "Dashboard",
                                      style: TextStyle(
                                          color: Colors.black38,
                                          fontSize: 12),
                                    ))
                              ],
                            )))
                        : Container()
                  ],
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[

                  // ElevatedButton(
                  //   child: Icon(Icons.arrow_forward),
                  //   onPressed: () {
                  //     webViewController?.goForward();
                  //   },
                  // ),
                  // ElevatedButton(
                  //   child: Icon(Icons.refresh),
                  //   onPressed: () {
                  //     webViewController?.reload();
                  //   },
                  // ),
                ],
              ),
            ]))));
  }
}