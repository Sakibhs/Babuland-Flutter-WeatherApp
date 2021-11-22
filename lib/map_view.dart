import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
 final String cityName, status, humidity, windSpeed;
 final int maxTemp, minTemp, temp;
 final double latitude, longitude;
  const MapView({Key? key, required this.cityName, required this.status,
   required this.humidity, required this.windSpeed, required this.maxTemp,
    required this.minTemp, required this.temp, required this.latitude,
    required this.longitude} ) : super(key: key);
  @override
  _MapViewState createState() => _MapViewState(cityName: cityName);
}

class _MapViewState extends State<MapView> {
  Set<Marker> _markers = {};
  var initialCameraPosition = CameraPosition(
      target: LatLng(23.7104, 90.4074),
    zoom: 12.0,
  );

  @override
  void initState() {
    initialCameraPosition = CameraPosition(target: LatLng(
      widget.latitude, widget.longitude
    ),
      zoom: 12.0,
    );
  }
  final String cityName;
  _MapViewState({required this.cityName});

  void _onMapCreated(GoogleMapController controller){
     setState(() {
       _markers.add(
         Marker(
           markerId: MarkerId("id-1"),
           position:LatLng(
             widget.latitude, widget.longitude
         ),
           infoWindow: InfoWindow(
             title: widget.cityName
           ),
         )
       );
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00804A),
        title: Text("WeatherApp"),
      ),
    body:CustomScrollView(
    slivers: [
    SliverFillRemaining(
    hasScrollBody: false,
   child: Column(
      children: [
        Container(
          height: 300.0,
          width: double.infinity,
          child: GoogleMap(
            zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              initialCameraPosition: initialCameraPosition,
            onMapCreated: _onMapCreated,
            markers: _markers,
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
                  SizedBox(height: 10),
                  Text(widget.status,),
                  SizedBox(height: 10),
                  Text("Humidity: "+widget.humidity),
                  SizedBox(height: 10),
                  Text("Wind Speed: "+widget.windSpeed,),
                  SizedBox(height: 10),
                  Text( "Max. Temp: ""${widget.maxTemp}"+"\u00B0"+"c",),
                  SizedBox(height: 10),
                  Text( "Min. Temp: ""${widget.maxTemp}"+"\u00B0"+"c"),
                  SizedBox(height: 10),
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
    ),],),
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
