
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
 final String cityName, status, humidity, windSpeed;
 final int maxTemp, minTemp, temp;
  const MapView({Key? key, required this.cityName, required this.status,
   required this.humidity, required this.windSpeed, required this.maxTemp,
    required this.minTemp, required this.temp} ) : super(key: key);
  @override
  _MapViewState createState() => _MapViewState(cityName: cityName);
}

class _MapViewState extends State<MapView> {
  // String status = "Loading..", humidity = "Loading..", windSpeed = "Loading..",
  //     maxTemp = "Loading..", minTemp = "Loading..", temp = "Loading..";
  static const initialCameraPosition = CameraPosition(
      target: LatLng(23.7104, 90.4074),
    zoom: 12.0,
  );
  final String cityName;
  _MapViewState({required this.cityName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00804A),
        title: Text("WeatherApp"),
      ),
    body: Column(
      children: [
        Container(
          height: 300.0,
          width: double.infinity,
          child: const GoogleMap(
            zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              initialCameraPosition: initialCameraPosition
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cityName,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),),
                  Align(
                    alignment: Alignment.topLeft,
                      child: Text(widget.status,)),
                  Text("Humidity: "+widget.humidity,
                  textAlign: TextAlign.start,),
                  Text("Wind Speed: "+widget.windSpeed,),
                  Text( "Max. Temp: ""${widget.maxTemp}"+"\u00B0"+"c",),
                  Text( "Min. Temp: ""${widget.maxTemp}"+"\u00B0"+"c"),
                ],
              ),
              Text( "${widget.temp}"+"\u00B0"+"c",
              style: TextStyle(
                fontSize: 25.0
              ),)
            ],
          ),
        )
      ],
    ),
    //   body: Container(
    //   child: CustomScrollView(
    //   slivers: [
    //   SliverFillRemaining(
    //   hasScrollBody: false,
    //   child: Column(
    //     children: [
    //       GoogleMap(initialCameraPosition: initialCameraPosition)
    //     ],
    //   ),
    // ),
    //   ],
    //   ),
    // ),
    );
  }
}
