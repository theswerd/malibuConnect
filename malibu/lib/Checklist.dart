import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:malibu/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:localstorage/localstorage.dart';
import 'color_loader_3.dart';
//Checklist item -- Title, Subtitle, Color, Emoji
class Checklist extends StatefulWidget {
  @override
  _ChecklistState createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  LocalStorage checklistStorage;
  Widget body = Center(child: ColorLoader3(),);
  bool readyG = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    checklistStorage = LocalStorage("checklist");
    checkReady(checklistStorage);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.antiColor,
        child: Icon(Icons.add),
        onPressed: (){
          if(readyG){
            Navigator.of(context).push(
              MaterialPageRoute(
                maintainState: true,
                fullscreenDialog: true,
                builder: (c)=>AddToChecklist(checklistStorage:checklistStorage)
              )
            );
          }else{
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text("Sorry, your checklist isn't ready yet"),
                backgroundColor: Constants.baseColor,
                behavior: SnackBarBehavior.fixed,
                action: SnackBarAction(
                  label: "Ok",
                  onPressed: ()=>_scaffoldKey.currentState.hideCurrentSnackBar(),
                  textColor: Colors.white,
                ),
              )
            );
          }
        },
      ),
      body: body,
    );
  }
  

  void checkReady(LocalStorage theStorage) async{
    Future<bool> readyF = theStorage.ready;
    bool ready = await readyF;
    if(ready){
      readyG = true;
      List storageList = theStorage.getItem("items");
      if(storageList == null){
        setState(() {
          body = emptyChecklist();
        });
      }
    }else{
      setState(() {
        try {
          theStorage.setItem("test", ['test','test','test']);
        } catch (e) {
        }
        
        body = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Sorry, we are having trouble accessing this device's local storage", style: TextStyle(color: Colors.black, fontSize: 19),),
            Text("Please check your settings to see if you are blocking our access somehow.", style: TextStyle(color: Colors.black, fontSize: 19))
          ],
        );
      });
    }
  }

  Widget emptyChecklist() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 22),
            children: [
              TextSpan(
                text: "Welcome to your "
              ),
              TextSpan(
                text: "School Checklist",
                style: TextStyle(fontWeight: FontWeight.bold)
              ),
              TextSpan(
                text: ". Press the "
              ),
              TextSpan(
                text: "purple button",
                style: TextStyle(color: Constants.antiColor, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: " at the bottom right of your screen to get started."
              ),
            ]
          ),
        )
      ]
    );
  }
}

class AddToChecklist extends StatefulWidget {
  AddToChecklist({@required checklistStorage});
  LocalStorage checklistStorage;
  @override
  _AddToChecklistState createState() => _AddToChecklistState();
}

class _AddToChecklistState extends State<AddToChecklist> {
  TextEditingController titleController;
  TextEditingController subtitleController;
  String emoji = "";
  String color = Colors.black.value.toString();
  
  LocalStorage checklistStorage;

  @override
  void initState() {
    super.initState();

    checklistStorage = widget.checklistStorage;

    titleController = new TextEditingController();
    subtitleController = new TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add to Checklist"),
        backgroundColor: Constants.baseColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 30.0),
        child: ListView(
          children: <Widget>[
            Row(children: <Widget>[
              Text("Title:", style: TextStyle(fontSize: 18)),
            ],),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                suffixText: "Required",
                hintText: "Do math homework",
                border: UnderlineInputBorder()
              ),
            ),
            Container(height: 40,),
            Row(children: <Widget>[
              Text("Subtitle:", style: TextStyle(fontSize: 18)),
            ],),
            TextField(
              controller: subtitleController,
              decoration: InputDecoration(
                hintText: "Very important",
                border: UnderlineInputBorder()
              ),
            ),
            Container(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Text("What Day:", style: TextStyle(fontSize: 18)),
              CupertinoButton.filled(
                child: Text("Add Day"),
                onPressed: (){
                  showModalBottomSheet(
                    context: context,
                    builder: (c){
                      return Container(
                        height: 400,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CupertinoButton(child: Text("Cancel"),onPressed: (){Navigator.of(context).pop();},)
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(0),
                              height: 340,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (newDate){
                                  print(newDate);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  );
                },
              )
            ],),

            
          ],
        ),
      ),
    );
  }
}