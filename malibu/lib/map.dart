

import 'package:flutter/material.dart';
import 'color_loader_3.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart' as mIcons;
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart'; 
class MapClass extends StatefulWidget {
  static String tag = "MAPP";
  @override
  _MapClassState createState() => new _MapClassState();
}

class _MapClassState extends State<MapClass> {

  double officeColor=BitmapDescriptor.hueBlue;
  Set<Map> classrooms = {
    /*{
      "name":"H204",
      "location":
    }*/
  };
  // Set<Marker> buildings = {
  //     Marker(
  //      markerId: MarkerId("Construction Zone"),
  //      position: LatLng(34.0129,-118.48647),
  //      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
  //      infoWindow: InfoWindow(
  //        title: "Construction Zone",
  //        snippet: "Projected to finish in 2021"
  //      ),
       
  //    ),
 
  //      Marker(
  //        markerId: MarkerId("Innovation"),
         
  //        icon: BitmapDescriptor.defaultMarker,
  //        position: LatLng(34.01367,-118.4858),
  //        infoWindow: InfoWindow(
  //          title: "I Building",
  //          snippet: "The innovation building"
  //        ),
  //        zIndex: 5
  //    ),
  //    Marker(
  //        markerId: MarkerId("English"),
         
  //        icon: BitmapDescriptor.defaultMarker,
  //        position: LatLng(34.0122,-118.48505),
  //        infoWindow: InfoWindow(
  //          title: "E Building",
  //          snippet: "The English Building"
  //        ),
  //        zIndex: 5
  //    ),
  //    Marker(
  //        markerId: MarkerId("History"),
         
  //        icon: BitmapDescriptor.defaultMarker,
  //        position: LatLng(34.0119,-118.48562),
  //        infoWindow: InfoWindow(
  //          title: "H Building",
  //          snippet: "The History Building"
  //        ),
  //        zIndex: 5
  //    ),
  //     Marker(
  //        markerId: MarkerId("Buisiness"),
         
  //        icon: BitmapDescriptor.defaultMarker,
  //        position: LatLng(34.0123,-118.48595),
  //        infoWindow: InfoWindow(
  //          title: "B Building",
  //          snippet: "The Buisiness Building"
  //        ),
  //        zIndex: 5
  //    ),
  //    Marker(
  //        markerId: MarkerId("Language"),
         
  //        icon: BitmapDescriptor.defaultMarker,
  //        position: LatLng(34.01165,-118.48490),
  //        infoWindow: InfoWindow(
  //          title: "L Building",
  //          snippet: "The Language Building"
  //        ),
  //        zIndex: 5
  //    ),
  //   Marker(
  //     markerId: MarkerId("Music"),
  //     icon: BitmapDescriptor.defaultMarker,
  //        position: LatLng(34.01165,-118.48690),
  //        infoWindow: InfoWindow(
  //          title: "Music Building",
  //          snippet: "Split between band, orchestra, and choir"
  //        ),
  //   ),
  //   Marker(
  //     markerId: MarkerId("T Building"),
  //     icon: BitmapDescriptor.defaultMarker,
  //        position: LatLng(34.01227,-118.4872),
  //        infoWindow: InfoWindow(
  //          title: "T Building",
  //          snippet: "The Temporary Buildings"
  //        ),
  //   ),
  //   Marker(
  //     markerId: MarkerId("North Gym"),
  //     icon: BitmapDescriptor.defaultMarker,
  //        position: LatLng(34.0112,-118.4873),
  //        infoWindow: InfoWindow(
  //          title: "North Gym",
  //          //snippet: ""
  //        ),
  //   ),//34.010829,-118.487066
  //   Marker(
  //     markerId: MarkerId("South Gym"),
  //     icon: BitmapDescriptor.defaultMarker,
  //        position: LatLng(34.010539,-118.486558),
  //        infoWindow: InfoWindow(
  //          title: "South Gym",
  //          //snippet: ""
  //        ),
  //   ),
  //   Marker(
  //     markerId: MarkerId("Pool"),
  //     icon: BitmapDescriptor.defaultMarker,
  //        position: LatLng(34.010829,-118.487066),
  //        infoWindow: InfoWindow(
  //          title: "The Pool",
  //          //snippet: ""
  //        ),
  //   ),//34.010539,-118.486558
  //   Marker(
  //     markerId: MarkerId("Cafeteria"),
  //     icon: BitmapDescriptor.defaultMarker,
  //        position: LatLng(34.011295,-118.485936),
  //        infoWindow: InfoWindow(
  //          title: "Cafeteria",
  //          //snippet: ""
  //        ),
  //   )
  // };
  // // buildings.add(constructionZone);

//34.012108,-118.485392
  Set<Marker> athletics = {
    Marker(
      position: LatLng(34.025087092370974, -118.8253204151988),
      markerId: MarkerId("field"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: "The Football Field", snippet: "The Shark's football field.")
    ),
    Marker(
      position: LatLng(34.02595127732184, -118.82661525160074),
      markerId: MarkerId("pool"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: "The Shark Tank", snippet: "The Malibu High School pool.")
    ),
    Marker(
      position: LatLng(34.0257717721044, -118.82691398262976),
      markerId: MarkerId("girlsLocker"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: "The Girls Locker Room", snippet: "The Malibu High School Girls Locker Room.")
    ),
    Marker(
      position: LatLng(34.025603103543254, -118.8266035169363),
      markerId: MarkerId("guysLocker"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: "The Guys Locker Room", snippet: "The Malibu High School Guys Locker Room.")
    ),//
    Marker(
      position: LatLng(34.02549556674031, -118.82688045501709),
      markerId: MarkerId("Gymnasium"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: "Gymnasium", snippet: "The Malibu High School Gymnasium.")
    ),
    Marker(
      position: LatLng(34.02535690797414, -118.82631719112396),
      markerId: MarkerId("Basketball"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: "Basketball", snippet: "The Malibu High School Basketball Courts.")
    ),
    Marker(
      position: LatLng(34.02534134705637, -118.82725361734629),
      markerId: MarkerId("new Gym"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: "Gymnasium", snippet: "The Malibu High School New Gymnasium.")
    ),
    Marker(
      position: LatLng(34.024095075002904, -118.8267708197236),
      markerId: MarkerId("Construction"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(title: "Construction", snippet: "The Malibu High School Construction Zone.")
    ),
    Marker(
      position: LatLng(34.0240547827359, -118.82640101015566),
      markerId: MarkerId("Blue Building"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(title: "Blue Building", snippet: "The Malibu High School Blue Building.")
    ),
    Marker(
      position: LatLng(34.024403518620076, -118.82704172283412),
      markerId: MarkerId("Mako Building"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(title: "Mako Building", snippet: "The Malibu High School Mako Building.")
    ),//
    Marker(
      position: LatLng(34.02487285094634, -118.82752016186713),
      markerId: MarkerId("Hammerhead Building"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(title: "Hammerhead Building", snippet: "The Malibu High School Hammerhead Building.")
    ),
    Marker(
      position: LatLng(34.02491286494999, -118.82690157741308),
      markerId: MarkerId("Angel Building"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(title: "Angel Building", snippet: "The Malibu High School Angel Building.")
    ),
    Marker(
      position: LatLng(34.024780874241394, -118.82659882307053),
      markerId: MarkerId("Leopard Building"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(title: "Leopard Building", snippet: "The Malibu High School Leopard Building.")
    ),
    Marker(
      position: LatLng(34.02457580195431, -118.82649857550861),
      markerId: MarkerId("Thresher Building"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(title: "Thresher Building", snippet: "The Malibu High School Thresher Building.")
    ),
    Marker(
      position: LatLng(34.02507875613889, -118.8266434147954),
      markerId: MarkerId("Amphitheatre"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      infoWindow: InfoWindow(title: "Amphitheatre", snippet: "The Malibu High School Amphitheatre.")
    ),
    Marker(
      position: LatLng(34.02431904408323, -118.82784236222506),
      markerId: MarkerId("Auditorium"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      infoWindow: InfoWindow(title: "Auditorium", snippet: "The Malibu High School Auditorium.")
    ),
  };
 
  GoogleMap googleMap(Set<Marker> buildings) {
    return GoogleMap(
      onTap: (c)=>print(c.latitude.toString()+", "+c.longitude.toString()),
      onCameraMove: (c){
        print(c.bearing);
        print(c.target);
        print(c.zoom);
      },
   compassEnabled: true,
   
   initialCameraPosition: CameraPosition(target: LatLng(34.02515378219823, -118.82590010762215),zoom: 17.474769592285156,tilt: 10, bearing: 30),
   mapType: MapType.hybrid,
   myLocationEnabled: true,
   markers: buildings,
   
   
 );
  }
  Widget body =Container(
    color: Colors.white,
    child: Center(child: ColorLoader3(),),
  );
  Widget mapWithRooms =Center(child: ColorLoader3(),);
  Widget mapWithBuildings = Container(
    color: Colors.white,
    child: Center(child: ColorLoader3(),),
  );
  Widget mapWithAll = Container(
    color: Colors.white,
    child: Center(child: ColorLoader3(),),
  );
  
  @override
  void initState() { 
    super.initState();
    setState(() {
      // mapWithAll =googleMap(buildings.union(rooms));
      // mapWithBuildings = googleMap(buildings);
      //mapWithRooms =googleMap(rooms);
      //googleMap({});
      body =  googleMap(athletics);
    });
    }
    
    
   // mapWithBuildings = googleMap(buildings) ;
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    body: body,
    
     
   );
  }
 
}

