import 'package:flutter/material.dart';
import 'package:location/location.dart';
void main() => runApp(
  MaterialApp(
    title: 'MyTracker',
    debugShowCheckedModeBanner: false,
    home: ListenPage(),
  )
);
class ListenPage extends StatefulWidget {
  @override
  _ListenPageState createState() => _ListenPageState();
}

class _ListenPageState extends State<ListenPage> {

  Location location =new Location();
  Future changeservice () async {
   await location.changeSettings(accuracy: LocationAccuracy.HIGH,interval: 100,distanceFilter: 10);
  }
  
   LocationData currentLocation;
  @override
  void initState()  {
    super.initState ();
    location.requestPermission();
    location.onLocationChanged().listen((value) {
      setState(() {
        currentLocation = value;
        changeservice();
        print(currentLocation.latitude);
        print(currentLocation.longitude);
        print(currentLocation.speed.round());
      });
    });
  }
        
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          currentLocation == null
              ? CircularProgressIndicator()
              : Text("\n\n\n\t\t\t\t\t\t\t\t\tLongitude:         "+currentLocation.latitude.toString()+"             Latitude:          "+currentLocation.longitude.toString()+"\n\n\n\n\n\n\t\t\t\t\t\t\t\t\t\t\t\t\t                                     Speed:      " + ((currentLocation.speed.round())*18/5).toString()+"  Kph"),
        ],
      ),
    );
  }
}