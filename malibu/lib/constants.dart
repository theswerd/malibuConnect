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
 static CupertinoActionSheetAction officialWebsiteAction(String website, String title, BuildContext context)=>CupertinoActionSheetAction(
   child: Text("Official Website"),
   onPressed: ()=>Navigator.of(context).push(
     MaterialPageRoute(
       fullscreenDialog: true,
       maintainState: true,
       builder: (c)=>WebviewScaffold(
         initialChild: Center(child: ColorLoader3(),),
         userAgent: "Malibu Connect",
         url: website,
         appBar: AppBar(
           backgroundColor: Constants.baseColor,
           title: Text("Official "+title),
           actions: <Widget>[IconButton(
             icon: Icon(Icons.launch),
             onPressed: ()=>launch(website),
           )],
         ),
       )
     )
   ),
 );
 static CupertinoActionSheetAction reportAction = CupertinoActionSheetAction(
   child:Text("Report a bug"),
   onPressed: ()=>launch(Constants.reportURL),
 );
}

