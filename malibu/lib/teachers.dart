

import 'package:flutter/material.dart';
import 'color_loader_3.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart' as mIcons;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' as s;
import 'package:vibrate/vibrate.dart';
//import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
import 'constants.dart';

class Teachers extends StatefulWidget {
  static String tag = "teachers";
  @override
  _TeachersState createState() => new _TeachersState();
  }
  
  class _TeachersState extends State<Teachers> with TickerProviderStateMixin{
  Widget bodyWidget = Center(child:ColorLoader3());
  Widget titleWidget = Text("Staff Directory");
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  AnimationController titleController;
  List teachers;
  List usedTeachers;
  bool hasGottenTeachers = false;
  bool isSearching = false;
  AppBar theAppBar;
  IconButton searchAction;
  @override
  void initState() {
    searchAction = IconButton(
      icon: (Icon(Icons.search)),
      onPressed: null,
    );
    titleController = new AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
      getTeachers();
            }
      @override
      Widget build(BuildContext context) {
       theAppBar = AppBar(
            actions: <Widget>[
              searchAction
            ],
          backgroundColor: Constants.baseColor,
          title: AnimatedSwitcher(child:titleWidget, duration: Duration(milliseconds: 500), switchInCurve: Curves.bounceInOut,switchOutCurve: Curves.bounceInOut,transitionBuilder: (w,a)=>ScaleTransition(child: w,scale: a,),)
        );

        return Scaffold(
          key: _scaffoldkey,
          appBar: theAppBar,
        body: bodyWidget,
        
        );
      }

      void getTeachers() async{
        Future<http.Response> theCall = http.get("http://www.malibu.smmusd.org/about/staff-directory.html");
        theCall.catchError((e){
          Navigator.of(context).pop();
          showCupertinoModalPopup(
            context: context,
            builder: (c)=>CupertinoAlertDialog(
              title: Text("Offline?"),
              content: Text("Sorry, it looks like there was an error loading your teachers"),
              actions: <Widget>[CupertinoDialogAction(child: Text("Ok"),onPressed: ()=>Navigator.of(context).pop(),)],
            )
          );
          return;
        });

        http.Response theResponse = await theCall;
        String body = theResponse.body;
        dom.Document htmlDoc = parse(body);
        //Just the body
        dom.Element theBody = htmlDoc.body;
        //Only has 1 child, still full website, then it goes to a table, then table body
        dom.Element permutation1 = theBody.children.first.children.first.children.first;
        //Permutation1 has 4 children -- 1:Title Image 2: Divider 3: Divider 4: Website Substance
        dom.Element permutation2 = permutation1.children.last;
        //Child is a table, then table body
        dom.Element permutation3 = permutation2.children.first.children.first.children.first;
        
        //Permuation 4 is the weirdest, of the 10 children, only the 3rd and 5th are relevant. 3rd is the search, 5th is what we are using
        dom.Element permutation4 = permutation3.children[4];
        //1 and 3 are padding, 2 is substance
        dom.Element permutation5 = permutation4.children[1];
        //Heading then the real substance, it is a table, then table body, then the teachers
        dom.Element permutation6 = permutation5.children.last.children.first;
        //print(permutation6.children);
        List<dom.Element> format1 = [];
        //Removing the dividers
        for (dom.Element item in permutation6.children) {
          if(item.children.length==3||item.children.length==4){
            format1.add(item);
          }
        }
        List format2 = [];
        //Removing the headers
        for (dom.Element item in format1) {
          if(item.children[1].text.trim().isNotEmpty && item.children[2].text.trim().isNotEmpty){
            try {
              List<dom.Element> unformattedTeacher = item.children;
              Map teacherMap = new Map();
              String teacherName = unformattedTeacher.first.text.trim();
              if(teacherName.contains(",")){
                teacherName = teacherName.split(", ")[1]+" "+teacherName.split(", ")[0];
              }
              
              teacherMap['name'] = teacherName;
              teacherMap['position'] = unformattedTeacher[1].text.trim();
              String extension = "";
              if(unformattedTeacher[2].text.trim().contains("x")){
                extension = "x"+unformattedTeacher[2].text.trim().split("x").last;
              }
              teacherMap['ex'] = extension;
              teacherMap['email'] =unformattedTeacher[3].text.isNotEmpty ?unformattedTeacher[3].text.trim():"";

              print(teacherMap);
              format2.add(teacherMap);
            } catch (e) {
            }
          }
        }

        teachers = format2;
        usedTeachers = teachers;
        

        setState(() {
          
          hasGottenTeachers = true;
          searchAction = IconButton(
                splashColor: hasGottenTeachers?Constants.antiColor:null,
                icon: (Icon(Icons.search)),
                onPressed: (){
                  
                  if(isSearching){
                    setState(() {
                      titleWidget = Text("Staff Directory");
                    });
                    isSearching = false;
                  }else{
                    setState(() {
                      titleWidget = new Container(
                        padding: EdgeInsets.only(bottom: 10, top: 2),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          onChanged: (name){
                            print(name);
                             // print("MADE IT HERE1");
                              //print(teachers);

                            List searchedTeacherList = [];
                            for (Map teacher in teachers) {
                              //print("MADE IT HERE");
                             // print(teacher);
                              if(teacher['name'].toUpperCase().contains(name.toUpperCase())||teacher['position'].toUpperCase().contains(name.toUpperCase())){
                                searchedTeacherList.add(teacher);
                               // print("adding Teacher");
                              }
                            }
                            print("IT GOT THROGUH");
                            usedTeachers = searchedTeacherList;
                            setState(() {
                                 bodyWidget = teacherViewMaker(usedTeachers, context, _scaffoldkey);//Container(color: Colors.accents[name.length],);

                            });
                            
                          },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: "Find for your teacher",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Constants.antiColor)
                          ),
                          // border: OutlineInputBorder(
                          //   borderSide: BorderSide(color: Colors.white),
                          //   borderRadius: BorderRadius.circular(25)
                          // )
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25)
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25)
                          )
                        ),
                      ),);
                    });
                    isSearching = true;

                  }
                },
              );

          bodyWidget = teacherViewMaker(usedTeachers, context, _scaffoldkey);
        });
        
      }

   
 
    }
     Widget teacherViewMaker(List teachers, BuildContext context, GlobalKey<ScaffoldState> _scaffoldkey) {
      print("rebuild");
      return ListView.separated(
        itemCount: teachers.length,
        padding: EdgeInsets.all(25),
        separatorBuilder: (c,i)=>Container(height: 30,),
        itemBuilder: (c,i)=>RaisedButton(
          splashColor: Constants.antiColor,
          padding: EdgeInsets.all(15),
          color: Colors.white,
          elevation: 15,
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(teachers[i]['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                Text(teachers[i]['ex'], style: TextStyle(fontSize: 18, color: Colors.grey[700]),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(child:Text(teachers[i]['position'], style: TextStyle(fontSize: 18, color: Colors.grey[700]), softWrap: true,)),
                //Text(teachers[i]['ex'], style: TextStyle(fontSize: 18, color: Colors.grey[700]),)
                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(child: Text(teachers[i]['email'], style: TextStyle(fontSize: 18),), onPressed: (){
                  showCupertinoModalPopup(
                    context: context,
                    builder: (c)=>CupertinoActionSheet(
                      cancelButton: CupertinoActionSheetAction(child: Text("Cancel"),onPressed: ()=>Navigator.of(context).pop(),),
                      actions: <Widget>[
                        CupertinoActionSheetAction(
                          child: Text("Share"),
                          onPressed: (){
                            Navigator.of(context).pop();
                            Share.share(teachers[i]['name']+"'s email is "+teachers[i]['email']);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: Text("Copy"),
                          onPressed: (){
                            try {
                              Vibrate.feedback(FeedbackType.success);
                            } catch (e) {
                            }
                            s.Clipboard.setData(s.ClipboardData(text: teachers[i]['email']));
                            Navigator.of(context).pop();
                            _scaffoldkey.currentState.showSnackBar(SnackBar(
                              backgroundColor: Constants.baseColor,
                              behavior: SnackBarBehavior.floating,
                              action: SnackBarAction(
                                textColor: Colors.white,
                                label: "Ok",
                                onPressed: ()=>_scaffoldkey.currentState.hideCurrentSnackBar(),
                              ),
                              content: Text(teachers[i]['name']+"'s email has been copied to your clipboard!"),
                            ));
                          },
                        )
                      ],
                    )
                  );
                },padding: EdgeInsets.zero,),
                FloatingActionButton(
                  onPressed: ()=>Share.share(teachers[i]['name']+"'s info:"+"\n"+"Position: "+teachers[i]['position']+"\n"+(teachers[i]['ex'].toString().trim().isNotEmpty?"Extension: "+teachers[i]['ex']+"\n":"")+(teachers[i]['email'].toString().trim().isNotEmpty?"Email: "+teachers[i]['email']+".":"")),
                  mini: true,
                  child: Icon(mIcons.MdiIcons.shareOutline),
                  backgroundColor: Constants.baseColor,
                )

              ],)
          ],),
          onPressed: (){},
        ),
      );
    }

