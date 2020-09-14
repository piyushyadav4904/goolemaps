import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goolemaps/health.dart';
import 'package:goolemaps/step.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'package:poly_collisions/poly_collisions.dart';

import 'dimeasion.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<LatLng> latLnglsit = [];
  List<mp.LatLng>list=new List();
  List<Point<num>> plist =new List();
  List<LatLng> paths = [];

  // ignore: non_constant_identifier_names
  List<Marker> MyMarker = [];

  @override
  void initState() {
    getpermission();
    super.initState();
  }

  void getpermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();
    print(statuses[Permission.location]);
  }
  String area="Area";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
          title: Text(area),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.add_comment),
              onPressed: () {},
            ),
          ]),
      body: GoogleMap(
        markers: Set.from(MyMarker),

        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(6.843369, 79.874814),
          zoom: 12.99,
        ),
        onTap: (LatLng latlang){
          _handleTap(latlang,-1);
        },
        polygons: Set<Polygon>.of(<Polygon>[
          if (latLnglsit.length > 2)
          Polygon(
                polygonId: PolygonId('test'),
                points: latLnglsit,
                //change this with getpoints() when you start first and add the points manually by emulater than relace it with latlnglist
                geodesic: true,
                strokeColor: Colors.red.withOpacity(0.6),
                strokeWidth: 5,
                fillColor: Colors.redAccent.withOpacity(0.1),
                visible: true),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        onPressed: () {
          var result = PolygonCollision.isConvexPolygon(plist);
          print(result);

          for(int i=0;i<latLnglsit.length;i++){
           var p1 = LatLng(latLnglsit[i].latitude, latLnglsit[i].longitude);
           for(int j=i+1;j<latLnglsit.length;j++){
             var p2 = LatLng(latLnglsit[j].latitude, latLnglsit[j].longitude);
             if(p1==p2){
               print(p1);
               print(p2);
               break;
             }

           }



          }

        },
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Abhishek Mishra"),
              accountEmail: Text("abhishekm977@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0, color: Colors.black87),
                ),
              ),
            ),
            ListTile(
              title: Text('map'),
              leading: Icon(Icons.map),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('health'),
              leading: Icon(Icons.save_alt),
              onTap: () {
                // Update the state of the app.
                 Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => Health()));
              },
            ),
            ListTile(
              title: Text('Group'),
              leading: Icon(Icons.group),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StepApp()));
              },
            ),
            ListTile(
              title: Text('synchronize'),
              leading: Icon(Icons.sync),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => dimeApp()));
              },
            ),
            ListTile(
              title: Text('import'),
              leading: Icon(Icons.import_export),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('setting'),
              leading: Icon(Icons.settings),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('saved contact us'),
              leading: Icon(Icons.message),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }

//direct add the poitn to draw a polygun
  getPoints() {
    return [
      LatLng(6.862462, 79.859482),
      LatLng(6.862258, 79.862325),
      LatLng(6.863121, 79.863644),
      LatLng(6.864538, 79.865039)
    ];
  }

  void _handleTap(LatLng argument,int index) {
    setState(() {
      print(argument);
      Marker marker=Marker(
          draggable: true,
          onDragEnd: (LatLng) {
            setState(() {
              int mrIndex=latLnglsit.indexOf(argument);
              MyMarker.removeAt(mrIndex);
              latLnglsit.removeAt(mrIndex);
              // latLnglsit.insert(mrIndex, LatLng);
              _handleTap(LatLng,mrIndex);
            });
          },
          consumeTapEvents: true,
          markerId: MarkerId(argument.toString()),
          position: argument,
          onTap: () {
            print("sdfkf");

          });

      if(index==-1){
        MyMarker.add(marker);
        latLnglsit.add(argument);
      }else{
        MyMarker.insert(index,marker);
        latLnglsit.insert(index,argument);


      }


      if(latLnglsit.length>2){
        list.clear();
        for(int i=0;i<latLnglsit.length;i++){
          list.add(new mp.LatLng(latLnglsit[i].latitude, latLnglsit[i].longitude));
          plist.add( new Point(latLnglsit[i].latitude, latLnglsit[i].longitude));
          paths.add(LatLng(latLnglsit[i].latitude, latLnglsit[i].longitude));
          
        }
        list.add(list[0]);

        setState(() {
          area=mp.SphericalUtil.computeArea(list).toString();
        });
      }
    });
  }


}