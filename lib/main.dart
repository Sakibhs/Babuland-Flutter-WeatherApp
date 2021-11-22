import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/map_view.dart';
import 'package:weather_app/splash.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}
//Degree Symbol "\u00B0"

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var results;

  Future getWeather() async{
    var url = Uri.parse('http://api.openweathermap.org/data/2.5/find?lat=23.68&lon=90.35&cnt=50&appid=e384f9ac095b2109c751d95296f8ea76');
    http.Response response = await http.get(url);
    results = jsonDecode(response.body);
  }

  @override
  void initState(){
    print("Hello");
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00804A),
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 50,
            itemBuilder: (BuildContext context, int position){
              return getRow(position);
            },
        ),
      ),
    );
  }


  Widget getRow(int position){
   var city, temperature, status, humidity, windSpeed,
       maxTemp, minTemp, latitude, longitude;
   String cityName, tempString, statusString, humidityString, windSpeedString,
    maxTempString, minTempString, latString, lonString;
   int tempInInt = 0, minTempInInt = 0, maxTempInInt = 0;
   double latDouble = 0.0, lonDouble = 0.0;
   cityName = "Loading...";
   tempString = "Loading...";
   statusString = "Loading...";

   humidityString = "Loading...";
   windSpeedString = "Loading...";
   maxTempString = "Loading...";
   minTempString = "Loading...";

   if(results==null) {
     Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {

      });

     });

   }
   else{
     city = results["list"][position]["name"];
     temperature = results["list"][position]["main"]["temp"];
     status = results["list"][position]["weather"][0]["main"];

     humidity = results["list"][position]["main"]["humidity"];
     windSpeed = results["list"][position]["wind"]["speed"];
     maxTemp = results["list"][position]["main"]["temp_max"];
     minTemp = results["list"][position]["main"]["temp_min"];

     latitude = results["list"][position]["coord"]["lat"];
     longitude = results["list"][position]["coord"]["lon"];


     cityName = city.toString();
     tempString = temperature.toString();
     statusString = status.toString();

     humidityString = humidity.toString();
     windSpeedString = windSpeed.toString();
     maxTempString = maxTemp.toString();
     minTempString = minTemp.toString();

     latString = latitude.toString();
     lonString = longitude.toString();


      double tempInDouble = double.parse(tempString) - 273.15;
      tempInInt = tempInDouble.round();

     double minTempInDouble = double.parse(minTempString) - 273.15;
     minTempInInt = minTempInDouble.round();

     double maxTempInDouble = double.parse(maxTempString) - 273.15;
     maxTempInInt = maxTempInDouble.round();

     latDouble = double.parse(latString);
     lonDouble = double.parse(lonString);

   }
     // return Container(
     //   padding: const EdgeInsets.symmetric(
     //     vertical: 10.0,
     //     horizontal: 5.0,
     //   ),
     //   child: Column(
     //     children: [
     //       new Align (child: new Text(cityName,
     //         style: new TextStyle(fontSize: 24.0),), //so big text
     //         alignment: FractionalOffset.topLeft,),
     //       new Align (child: new Text(
     //        "$tempInInt"+"\u00B0"+"c"
     //       ),
     //         alignment: FractionalOffset.centerRight,),
     //       new Align (child: new Text(statusString,
     //       style: TextStyle(
     //         color: Color(0xff6a5959),
     //       ),),
     //         alignment: FractionalOffset.topLeft,),
     //       new Divider (color: Color(0xffcccccc),),
     //     ],
     //   ),
     // );


    return GestureDetector(
      onTap: (){
        var route = MaterialPageRoute(
          builder: (BuildContext context) => MapView(cityName: cityName,
          status: statusString, humidity: humidityString, windSpeed: windSpeedString,
          temp: tempInInt, maxTemp: maxTempInInt, minTemp: minTempInInt,
          latitude: latDouble, longitude: lonDouble,),
        );
        Navigator.of(context).push(route);
      },
      child: Column(
        children: [
          ListTile(
            title: Text(cityName),
            subtitle: Text(statusString),
            trailing: Wrap(
              children: [
              Text(
                "$tempInInt"+"\u00B0"+"c",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
              ],
            ),
          ),
          Divider(color: Color(0xffcccccc)),
        ],
      ),
    );
  }


}
