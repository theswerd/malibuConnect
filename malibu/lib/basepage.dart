import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:malibu/Checklist.dart';
import 'package:malibu/teachers.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:malibu/calender.dart';
import 'package:malibu/homepage.dart';
import 'map.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin{
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController baseTabController;
  TabBarView thebody;
  @override
  void initState() {
    super.initState();
    baseTabController = new TabController(vsync: this, length: 3);
    thebody = TabBarView(
      physics: NeverScrollableScrollPhysics(),
        controller: baseTabController,
        children: <Widget>[
       //   HomePage(),
          MapClass(),
          Calendar(),
          Checklist()

        ],
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: thebody,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Constants.baseColor
              ),
              child: Image.asset('assets/baselogo.png'),
            ),
            ListTile(
              title: Text("Staff Directory"),
              subtitle: Text("Find your teachers"),
              leading: Icon(MdiIcons.teach, color: Colors.black,),
              onTap: ()=>Navigator.of(context).push(
                MaterialPageRoute(
                  builder:(c)=>Teachers(),
                  fullscreenDialog: true,
                  maintainState: true
                )
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.info_outline),onPressed: (){
            List<Widget> children = [];
            switch (baseTabController.index) {
              case 0:
              children = [
                CupertinoActionSheetAction(
                  child: Text("Extra Info"),
                  onPressed: ()=>showCupertinoModalPopup(
                    context:context,
                    builder: (c)=>CupertinoAlertDialog(
                      title: Text("Extra Info"),
                      content: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: <TextSpan>[//officialWebsiteAction
                            TextSpan(text: "The "),
                            TextSpan(text: "Malibu High School", style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: " app is your personal assistant through your time at "),
                            TextSpan(text: "Malibu High School.", style: TextStyle(fontWeight: FontWeight.bold))
                          ]
                        ),
                      ),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: Text("Ok"),
                          onPressed: ()=>Navigator.of(context).pop(),
                        )
                      ],
                    )
                  ),

                ),
                Constants.officialWebsiteAction("http://www.malibu.smmusd.org/about/images/MHS-Campus-Map.gif", "Map", context),
                Constants.reportAction,
                CupertinoActionSheetAction(
                  child: Text("Share"),
                  onPressed: ()=>Share.share("Check out Malibu High Schools new app!\n\n "+Constants.ourWebsite),
                )
              ];
                break;
              case 1:
              children = [
                CupertinoActionSheetAction(
                  child: Text("Extra Info"),
                  onPressed: ()=>showCupertinoModalPopup(
                    context:context,
                    builder: (c)=>CupertinoAlertDialog(
                      title: Text("Extra Info"),
                      content: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: <TextSpan>[//officialWebsiteAction
                            TextSpan(text: "The "),
                            TextSpan(text: "Calendar", style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: " is taken live from the "),
                            TextSpan(text: "Malibu High School official Calendar.", style: TextStyle(fontWeight: FontWeight.bold))
                          ]
                        ),
                      ),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: Text("Ok"),
                          onPressed: ()=>Navigator.of(context).pop(),
                        )
                      ],
                    )
                  ),

                ),
                Constants.officialWebsiteAction("http://www.malibu.smmusd.org/calendar.html", "Calendar", context),
                CupertinoActionSheetAction(
                  child: Text("District Calendar"),
                  onPressed: ()=>Navigator.of(context).push(
                    MaterialPageRoute(
                      maintainState: true,
                      fullscreenDialog: true,
                      builder:(c)=>WebviewScaffold(url: "http://www.smmusd.org/calendar/cal1920.pdf",
                       appBar: AppBar(
                         title: Text("District Calendar"),
                         backgroundColor: Constants.baseColor,
                         actions: <Widget>[Tooltip(message: "Official Website", child: IconButton(icon: Icon(MdiIcons.launch),onPressed: ()=>launch("http://www.smmusd.org/calendar/cal1920.pdf"),),),],
                         ),)
                    )
                  ),
                ),
                Constants.reportAction,
                CupertinoActionSheetAction(
                  child: Text("Share"),
                  onPressed: ()=>Share.share("Check out Malibu High Schools new app!\n\n "+Constants.ourWebsite),
                )
              ];
                
                break;
              case 2:
                break;
              case 3:
                break;
            }
            showCupertinoModalPopup(
              context: context,
              builder: (c)=>CupertinoActionSheet(
                title: Text("Extra Info"),
                actions: children,
                cancelButton: CupertinoActionSheetAction(
                  child: Text("Cancel"),
                  onPressed: ()=>Navigator.of(context).pop(),
                ),
              )
            );
          },)
        ],
        leading: Tooltip(
          message: "Menu Button",
          child: IconButton(
            icon: Icon(Icons.menu),
            onPressed: ()=>scaffoldKey.currentState.openDrawer(),
            
          ),
        ),
        backgroundColor: Constants.baseColor,
        
        title: TabBarView(
          controller: baseTabController,
          children: <Widget>[
            Center(child:Text("Malibu High School")),
            //Center(child:Text("Map")),
            Center(child:Text("Calendar")),
            Center(child:Text("Checklist"))

          ],
        ),
      ),
      bottomNavigationBar: TabBar(
        controller: baseTabController,
        indicatorColor: Constants.baseColor,
        labelColor: Constants.baseColor,
        unselectedLabelColor: Colors.black,
        tabs: <Widget>[
          // Tab(
          //   icon: Icon(MdiIcons.homeOutline),
          // ),
          Tab(
            icon: Icon(MdiIcons.mapOutline)
          ),
          Tab(
            icon: Icon(MdiIcons.calendarTextOutline)
          ),
          Tab(
            icon: Icon(MdiIcons.clipboardCheckOutline),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}