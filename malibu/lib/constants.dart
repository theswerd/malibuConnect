import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:malibu/color_loader_3.dart';
import 'package:url_launcher/url_launcher.dart';

class Constants {
 static Color baseColor  = Color(0xFF00A79D);
 static Color antiColor = Colors.deepPurpleAccent;// possible secondary
 static String ourWebsite = "";
 static String reportURL = "https://forms.gle/8vCkCU597ZGsfGNF9";
 static String joinTheTeamURL = "https://forms.gle/HTQfeA99kJvcXyNT7";
 static String feedbackURL = "https://forms.gle/2L6Mp1ASNDRyYpiA9";
 static CupertinoActionSheetAction officialWebsiteAction(String website, String title, BuildContext context)=>CupertinoActionSheetAction(
   child: Text("Official Website"),
   onPressed: ()=>Navigator.of(context).push(
     websitePage(website, title)
   ),
 );

 static MaterialPageRoute websitePage(String website, String title) {
   return MaterialPageRoute(
     fullscreenDialog: true,
     maintainState: true,
     builder: (c)=>WebviewScaffold(
       initialChild: Center(child: ColorLoader3(),),
       userAgent: "Malibu Connect",
       url: website,
       appBar: AppBar(
         backgroundColor: Constants.baseColor,
         title: Text(title),
         actions: <Widget>[IconButton(
           icon: Icon(Icons.launch),
           onPressed: ()=>launch(website),
         )],
       ),
     )
   );
 }
 static CupertinoActionSheetAction reportAction = CupertinoActionSheetAction(
   child:Text("Report a bug"),
   onPressed: ()=>launch(Constants.reportURL),
 );
}

