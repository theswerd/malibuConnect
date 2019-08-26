import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'constants.dart';
import 'dart:async';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.baseColor,
        title: Text("Schedule"),
        actions: <Widget>[
          IconButton(
            icon: Icon(MdiIcons.informationOutline),
            onPressed: ()=>showCupertinoModalPopup(
              context: context,
              builder: (c)=>CupertinoActionSheet(
                title: Text("Extra Info"),
                cancelButton: CupertinoActionSheetAction(
                  child: Text("Cancel"),
                  onPressed: ()=>Navigator.of(context).pop(),
                ),
                actions: <Widget>[
                  CupertinoActionSheetAction(
                    child: Text("Extra Info"),
                    onPressed: ()=>showCupertinoModalPopup(
                      context: context,
                      builder: (c)=>CupertinoAlertDialog(
                        title: Text("Extra Info"),
                        content: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: "The school schedule was taken from the "
                              ),//August 25th
                              TextSpan(
                                style: TextStyle(fontWeight: FontWeight.bold),
                                text: "official school website"
                              ),
                              TextSpan(
                                text: " on "
                              ),
                              TextSpan(
                                style: TextStyle(fontWeight: FontWeight.bold),
                                text: "August 25th"
                              ),
                              TextSpan(
                                text: "."
                              ),
                            ]
                          ),
                        ),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text("Ok"),
                            onPressed: ()=>Navigator.of(context).pop(),
                          ),
                        ],
                      )
                    ),
                  ),
                  Constants.officialWebsiteAction("http://www.malibu.smmusd.org/about/bell-schedule.html", "Schedule", context),
                  CupertinoActionSheetAction(
                    child: Text("Report a bug"),
                    onPressed: ()=>Navigator.of(context).push(
                      Constants.websitePage(Constants.reportURL, "Report")
                    ),
                  )
                ],
              )
            ),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: <Widget>[
          RaisedButton(
            onPressed: (){},
            color: Colors.white,
            elevation: 25,
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Monday/Tuesday", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                    Text("Normal", style: TextStyle(fontSize: 21, fontWeight: FontWeight.normal, color: Colors.grey[700]),)
                  ],
                ),
                Container(height: 10,),
                RaisedButton(
                  onPressed: (){},
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Period 1", style: TextStyle(fontSize: 20),),
                      Text("7:50", style: TextStyle(fontSize: 19, color: Colors.grey[700]) ,)
                    ],
                  ),
                ), 
                Container(height: 25,),
                RaisedButton(
                  onPressed: (){},
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Period 2", style: TextStyle(fontSize: 20),),
                      Text("8:55", style: TextStyle(fontSize: 19, color: Colors.grey[700]),)
                    ],
                  ),
                ), 
                Container(height: 25,),
                RaisedButton(
                  onPressed: (){},
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Period 3", style: TextStyle(fontSize: 20),),
                      Text("10:10", style: TextStyle(fontSize: 19, color: Colors.grey[700]),)
                    ],
                  ),
                ), 
                Container(height: 25,),
                RaisedButton(
                  onPressed: (){},
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Lunch", style: TextStyle(fontSize: 20),),
                      Text("11:10", style: TextStyle(fontSize: 19, color: Colors.grey[700]),)
                    ],
                  ),
                ), 
                Container(height: 25,),
                RaisedButton(
                  onPressed: (){},
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Period 4", style: TextStyle(fontSize: 20),),
                      Text("11:50", style: TextStyle(fontSize: 19, color: Colors.grey[700]),)
                    ],
                  ),
                ), 
                Container(height: 25,),
                RaisedButton(
                  onPressed: (){},
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Period 5", style: TextStyle(fontSize: 20),),
                      Text("12:55", style: TextStyle(fontSize: 19, color: Colors.grey[700]),)
                    ],
                  ),
                ), 
                Container(height: 25,),
                RaisedButton(
                  onPressed: (){},
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Period 6", style: TextStyle(fontSize: 20),),
                      Text("2:00", style: TextStyle(fontSize: 19, color: Colors.grey[700]),)
                    ],
                  ),
                ), 
                Container(height: 20,)
              ],
            ),
          ),
          Container(height: 30,),
          RaisedButton(
            onPressed: (){},
            color: Colors.white,
            elevation: 25,
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Wednesday/Thurdsay", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                    Text("Block", style: TextStyle(fontSize: 21, fontWeight: FontWeight.normal, color: Colors.grey[700]),)
                  ],
                ),
                Container(height: 10,),
                RaisedButton(
                  onPressed: (){},
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Period 1 / 2", style: TextStyle(fontSize: 20),),
                      Text("7:50", style: TextStyle(fontSize: 19, color: Colors.grey[700]) ,)
                    ],
                  ),
                ), 
                Container(height: 25,),
                RaisedButton(
                  onPressed: (){},
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Period 3 / 4", style: TextStyle(fontSize: 20),),
                      Text("9:45", style: TextStyle(fontSize: 19, color: Colors.grey[700]),)
                    ],
                  ),
                ), 
                Container(height: 25,),
                RaisedButton(
                  onPressed: (){},
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Lunch", style: TextStyle(fontSize: 20),),
                      Text("11:30", style: TextStyle(fontSize: 19, color: Colors.grey[700]),)
                    ],
                  ),
                ), 
                Container(height: 25,),
                RaisedButton(
                  onPressed: (){},
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Support", style: TextStyle(fontSize: 20),),
                      Text("12:10", style: TextStyle(fontSize: 19, color: Colors.grey[700]),)
                    ],
                  ),
                ), 
                Container(height: 25,),
                RaisedButton(
                  onPressed: (){},
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Period 5 / 6", style: TextStyle(fontSize: 20),),
                      Text("1:15", style: TextStyle(fontSize: 19, color: Colors.grey[700]),)
                    ],
                  ),
                ), 
                Container(height: 20,),
                
              ],
            ),
          ),
          Container(height: 25,),
          RaisedButton(
                  onPressed: (){},
                  color: Colors.white,
                  elevation: 25,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Friday", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                          Text("Minimum Day", style: TextStyle(fontSize: 21, fontWeight: FontWeight.normal, color: Colors.grey[700]),)
                        ],
                      ),
                      Container(height: 10,),
                      RaisedButton(
                        onPressed: (){},
                        padding: EdgeInsets.all(15),
                        color: Colors.white,
                        elevation: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Period 1", style: TextStyle(fontSize: 20),),
                            Text("7:55", style: TextStyle(fontSize: 19, color: Colors.grey[700]) ,)
                          ],
                        ),
                      ), 
                      Container(height: 25,),
                      RaisedButton(
                        onPressed: (){},
                        padding: EdgeInsets.all(15),
                        color: Colors.white,
                        elevation: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Period 2", style: TextStyle(fontSize: 20),),
                            Text("8:40", style: TextStyle(fontSize: 19, color: Colors.grey[700]),)
                          ],
                        ),
                      ), 
                      Container(height: 25,),
                      RaisedButton(
                        onPressed: (){},
                        padding: EdgeInsets.all(15),
                        color: Colors.white,
                        elevation: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Nutrition", style: TextStyle(fontSize: 20),),
                            Text("9:20", style: TextStyle(fontSize: 19, color: Colors.grey[700]),)
                          ],
                        ),
                      ), 
                      Container(height: 25,),
                      RaisedButton(
                        onPressed: (){},
                        padding: EdgeInsets.all(15),
                        color: Colors.white,
                        elevation: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Period 3", style: TextStyle(fontSize: 20),),
                            Text("9:45", style: TextStyle(fontSize: 19, color: Colors.grey[700]),)
                          ],
                        ),
                      ), 
                      Container(height: 25,),
                      RaisedButton(
                        onPressed: (){},
                        padding: EdgeInsets.all(15),
                        color: Colors.white,
                        elevation: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Period 4", style: TextStyle(fontSize: 20),),
                            Text("10:30", style: TextStyle(fontSize: 19, color: Colors.grey[700]),)
                          ],
                        ),
                      ), 
                      Container(height: 25,),
                      RaisedButton(
                        onPressed: (){},
                        padding: EdgeInsets.all(15),
                        color: Colors.white,
                        elevation: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Period 5", style: TextStyle(fontSize: 20),),
                            Text("11:15", style: TextStyle(fontSize: 19, color: Colors.grey[700]),)
                          ],
                        ),
                      ), 
                      Container(height: 25,),
                      RaisedButton(
                        onPressed: (){},
                        padding: EdgeInsets.all(15),
                        color: Colors.white,
                        elevation: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Period 6", style: TextStyle(fontSize: 20),),
                            Text("12:00", style: TextStyle(fontSize: 19, color: Colors.grey[700]),)
                          ],
                        ),
                      ), 
                      Container(height: 20,)
                    ],
                  ),
                ),
                Container(height: 30,),

        ],
      ),
    );
  }
}