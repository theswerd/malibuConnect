import 'package:flutter/material.dart';
import 'package:malibu/constants.dart';
import 'color_loader_3.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart'as dom;

import 'package:localstorage/localstorage.dart';

class Calendar extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
 static String tag = "CalenderView";
  Calendar();

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _CalendarState createState() => new _CalendarState();
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {
  Widget calendarBody;
  String currentDay = DateTime.now().year.toString()+"-"+DateTime.now().month.toString()+"-"+DateTime.now().day.toString();
  @override
  void initState() {
    Widget networkCalendar =  StreamBuilder(
       //stream:http.get("https://calendar.google.com/calendar/htmlembed?mode=AGENDA&src=smmk12.org_21bhbi3q00vuvdf2rak3rrrll8%40group.calendar.google.com").asStream(),
       stream:http.get("https://calendar.google.com/calendar/htmlembed?mode=AGENDA&wkst=1&bgcolor=%23ffffff&ctz=America%2FLos_Angeles&src=OHRuMW9ucXZrdXA2ZzI4MXExOXM2b29uM3NAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ&src=c3RiM3JlZmRqYjhtYTdkajJ1OGFyNGh1ZXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ&src=dGxrdjhmaG0xaHBhYjYzM3NldGNvbHRmamdAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ&color=%23F09300&color=%233F51B5&color=%23D50000&title=Malibu%20HS").asStream(),
       builder: (c,s){
         if(s.hasError){
           return Center(child:
               RichText(
                 textAlign: TextAlign.center,
                 
                               text: TextSpan(
                                 children: <TextSpan>[
                                   TextSpan(text: "Sorry, it looks like your ",style: TextStyle(color: Colors.black, fontSize: 18)),
                                   TextSpan(text: "offline",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black, fontSize: 18))

                                 ]
                               ),
                             )
             
           ); 
         }
         if(s.connectionState!=ConnectionState.done){
           return Center(child:ColorLoader3());
         }else{
           http.Response response = s.data;
           //FULL DOCUMENT
           dom.Document p1 = parse(response.body); 
           //BODY
           dom.Element p2 = p1.body;
           //CALENDER
           dom.Element p3 = p2.getElementsByClassName("view-container-border")[0];
           //DAYS
           List<dom.Element> p4 = p3.firstChild.children;
           List days = [];
           for (dom.Element item in p4) {
             print("NEW ITEM");
             //print(item.children.last);
             print("DAY:");
             String day = item.firstChild.text.trim();
             //print(day.text.trim());
             
             dom.Element eventsTable = item.children.last;
             dom.Element eventsTableBody =eventsTable.firstChild;
             //print(eventsTableBody.children);
             List events = [];
             for (var event in eventsTableBody.children) {

               //print("time: "+event.children[0].text.trim()+", event: "+event.children[1].text.trim());
                events.add([event.children[0].text.trim(),event.children[1].text.trim()]);
             }
             //print(events);
             var todaysMap = new Map();
             todaysMap["day"]=day;
             todaysMap["events"]=events;
             days.add(todaysMap);

           }

           print(days);
           return calendarViewMaker(days);
         }
       },
     );
    super.initState();
    calendarBody = networkCalendar;
    setCalendarType();
    setCalendarTest();
        }
    
      @override
      Widget build(BuildContext context) {
      
       return Scaffold(
         body: calendarBody
         
         );
      }
    
       ListView calendarViewMaker(List days) {
        storeTodaysCalendar(days);
            return ListView.builder(
                   itemCount: days.length,
                   itemBuilder: (c,i){
                     Map today = days[i];
                     return Container(
                       padding: EdgeInsets.symmetric(horizontal:30,vertical: 20),
                       child:Card(
                         color: Colors.white,
                         
                       elevation: 10,
                       child: Column(
                         
                         children: <Widget>[
                           Row(children: <Widget>[
                             Container(
                               padding: EdgeInsets.only(left:20,top: 20),
                               child: 
                             Text(today["day"],style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)
                             )
                           ],),
                          // Text(today["events"].length.toString()),
                           Container(
                             height: (today["events"].length*125).toDouble(),
                             child: ListView.builder(
                               itemCount: today["events"].length,
                               itemBuilder: (c,i){
                                 String time =  today["events"][i][0];
                                 if(time ==""){
                                   time = "All Day";
                                 }
                                 String event = today["events"][i][1];
                                 return Container(
                                   padding: EdgeInsets.all(20),
                                   child: RaisedButton(
                                     onPressed: (){},
                                     padding: EdgeInsets.all(15),
                                     color: Colors.white,
                                     elevation: 10,
                                     child: Column(  
                                       children: <Widget>[
                                        Text(time, style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                                        Container(height: 5,),
                                        Text(event,style: TextStyle(color: Colors.grey[700],fontSize: 18),textAlign: TextAlign.center,)
                                       ],),
                                   ),
                                 );
                               },
                             ),
                             )
                       
                       ],
                       ),
                       //child: Text(today.toString()),
                     ),
                     
                     );
                   },
                 );
           }
           void setCalendarType() async{
             LocalStorage theStorage =  LocalStorage("calendar");
             Future<bool> ready = theStorage.ready;
            if(await ready){
              
            
              print("READDYY:");
              print(await ready);
            List allStorage;
            try {
              allStorage = theStorage.getItem(currentDay);
            } catch (e) {
            }
            allStorage = theStorage.getItem(currentDay);
            if(allStorage==null){
              //Sometimes it won't work till data is inputted
              theStorage.setItem("tryWork", ['1','2','3']);
              theStorage.clear();
              
            }else{
              setState(() {
                calendarBody = calendarViewMaker(allStorage);

              });
            }
            }else{
              setState(() {
                calendarBody = Container(color: Colors.orange,);
              });
              return;
            }
        
          }
        
          void storeTodaysCalendar(List days) async{
            LocalStorage theStorage =  LocalStorage("calendar");
             Future<bool> ready = theStorage.ready;
            if(await ready){
              theStorage.setItem(currentDay, days);
            }else{
              return;
            }
            
        
          }
        
          void setCalendarTest() {
            setState(() {
             // calendarBody = Container(color:Constants.baseColor,);
            });
          }
      
    }

  

  