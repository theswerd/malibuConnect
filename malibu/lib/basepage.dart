import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:localstorage/localstorage.dart';
import 'package:malibu/Checklist.dart';
import 'package:malibu/color_loader_3.dart';
import 'package:malibu/schedulePage.dart';
import 'package:malibu/teachers.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:upgrader/upgrader.dart';
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
      if(Upgrader().isUpdateAvailable()){}
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
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Constants.baseColor
              ),
              child: Image.asset('assets/baselogo.png'),
            ),
            Container(height: 40,color: Colors.grey[200],child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(child: Text("Important Pages:"), padding: EdgeInsets.all(5),)
              ],
            ),),
            ListTile(
              title: Text("Illuminate"),
              subtitle: Text("Gradebook"),
              trailing: Icon(MdiIcons.bookOpenVariant, color: Colors.black,),
              onTap: ()=>Navigator.of(context).push(
                Constants.websitePage("https://smmusd.illuminatehc.com", "Illuminate")
              )
            ),
            ListTile(
              title: Text("Clever"),
              subtitle: Text("For College"),
              trailing: Icon(MdiIcons.school, color: Colors.black,),
              onTap: ()=>Navigator.of(context).push(
                Constants.websitePage("https://clever.com/oauth/authorize?channel=clever&client_id=4c63c1cf623dce82caac&confirmed=true&redirect_uri=https%3A%2F%2Fclever.com%2Fin%2Fauth_callback&response_type=code&state=24ce2f1cc162ab5b9c4bc5ec7fe82c151a1b49a04a3958351ef5a61fa300cb60&target=%3BNGM2M2MxY2Y2MjNkY2U4MmNhYWM%3D%3BaHR0cHM6Ly9jbGV2ZXIuY29tL2luL2F1dGhfY2FsbGJhY2s%3D%3BMjRjZTJmMWNjMTYyYWI1YjljNGJjNWVjN2ZlODJjMTUxYTFiNDlhMDRhMzk1ODM1MWVmNWE2MWZhMzAwY2I2MA%3D%3D%3BY29kZQ%3D%3D&district_id=52e02e628b625cb10d006ce5", "Clever")
              )
            ),
            ListTile(
              title: Text("Staff Directory"),
              subtitle: Text("Find your teachers"),
              trailing: Icon(MdiIcons.teach, color: Colors.black,),
              onTap: ()=>Navigator.of(context).push(
                MaterialPageRoute(
                  builder:(c)=>Teachers(),
                  fullscreenDialog: true,
                  maintainState: true
                )
              ),
            ),
            ListTile(
              title: Text("Schedule"),
              subtitle: Text("School Bell Schedule"),
              trailing: Icon(MdiIcons.clockOutline, color: Colors.black,),
              onTap: ()=>Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  maintainState: true,
                  builder: (c)=>SchedulePage()
                ),
              )
            ),
            ListTile(
              title: Text("District Website"),
              subtitle: Text("www.smmusd.org/"),
              trailing: Icon(MdiIcons.pencilOutline, color: Colors.black,),
              onTap: ()=>Navigator.of(context).push(
                Constants.websitePage("http://www.smmusd.org", "District Website")
              )
            ),
            ListTile(
              title: Text("School Website"),
              subtitle: Text("Malibu High School"),
              trailing: Icon(MdiIcons.chairSchool, color: Colors.black,),
              onTap: ()=>Navigator.of(context).push(
                Constants.websitePage("http://www.malibu.smmusd.org/", "School Website")
              )
            ),
            Container(height: 55,child: Text("Developed by Benjamin Swerdlow\n ©SwerdIsTheWord"), padding: EdgeInsets.all(10),color: Colors.grey[200],),
            ListTile(
              title: Text("Report a bug or mistake"),
              subtitle: Text("We need your feedback!"),
              trailing: Icon(MdiIcons.bugOutline, color: Colors.black,),
              onTap: ()=>Navigator.of(context).push(
                Constants.websitePage(Constants.reportURL, "Report")
              )
            ),
            ListTile(
              title: Text("Join the Team"),
              subtitle: Text("You can be a part of the Malibu High School App."),
              trailing: Icon(MdiIcons.emoticonCoolOutline, color: Colors.black,),
              onTap: ()=>Navigator.of(context).push(
                Constants.websitePage(Constants.joinTheTeamURL, "Join the Team")
              )
            ),
            ListTile(
              title: Text("Feedback"),
              subtitle: Text("Help make the Malibu High School App even better!"),
              trailing: Icon(MdiIcons.contactPhoneOutline,color: Colors.black,),
              onTap: ()=>Navigator.of(context).push(
                Constants.websitePage(Constants.feedbackURL, "Feedback")
              )
            ),
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
                Constants.officialWebsiteAction("http://www.malibu.smmusd.org/about/images/MHS-Campus-Map.gif", "Official Map", context),
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
                Constants.officialWebsiteAction("http://www.malibu.smmusd.org/calendar.html", "Official Calendar", context),
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
                children = [
                  CupertinoActionSheetAction(
                    child: Text("Clear"),
                    onPressed: (){
                      Navigator.of(context).pop();
                      LocalStorage("checklist").clear();
                      build(context);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (c)=>MainPage()
                        )
                      );

                    },
                  )
                ];
                break;
              // case 3:
              //   break;
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