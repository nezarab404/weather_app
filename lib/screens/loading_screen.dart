import 'package:flutter/material.dart';
import 'package:flutter2/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart'as http;

import 'location_screen.dart';

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  Future<bool> checkInternet()async{
    http.Response check = await http.get(Uri.https('www.google.com', ''));
    if(check.statusCode == 200) return true;
    return false;
  }
  void getLocationData() async {
    if(await checkInternet()) {
      var weatherData = await WeatherModel().getLocationData();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LocationScreen(
                    locationWeather: weatherData,
                  )));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitWanderingCubes(
              color: Colors.blueAccent,
              size: 100,
            ),
            Text('Checking Location Data ...',style: TextStyle(color: Colors.black,fontSize: 25),),

          ],
        ),
      ),
    );
  }
}
