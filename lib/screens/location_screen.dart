//import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/utilities/constants.dart';
import 'package:flutter2/services/weather.dart';
import 'package:flutter/cupertino.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var weatherData;
  WeatherModel weatherModel = WeatherModel();

  //curved navi bar
  // GlobalKey _bnb = GlobalKey();
  // int page = 0;

  //data
  var temperature ;
  /*double*/var windSpeed;
  /*double*/var humidity;
  /*double*/var rain;
  String weatherIcon = 'l';
  String cityName = 'k';
  String message = 'j';
  String description = 'd';
  String status = 's';
  String img;
  IconData ico;
  var sunset, sunrise,dt;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      var temp = weatherData['main']['temp'];
      temperature = temp;
      var condition = weatherData['weather'][0]['id'];
      message = weatherModel.getMessage(temp.toString());
      weatherIcon = weatherModel.getWeatherIcon(condition);
      cityName = weatherData['name'];
      description = weatherData['weather'][0]['description'];
      status = weatherData['weather'][0]['main'];
      windSpeed = weatherData['wind']['speed'];
      humidity = weatherData['main']['humidity'];
      sunset = weatherData['sys']['sunset'];
      sunrise = weatherData['sys']['sunrise'];
      dt = weatherData['dt'];
      choose();
    });
  }

  void choose() {
    if (status == 'Rain' || status == 'Drizzle') {
      img = 'images/rainy.jpg';
      ico = CupertinoIcons.cloud_rain_fill;
    } else if (status == 'Clear') {
      var a = DateTime.fromMillisecondsSinceEpoch(sunrise);
      var b = DateTime.fromMillisecondsSinceEpoch(sunset);
      var n = DateTime.now();
      var d = DateTime.fromMicrosecondsSinceEpoch(dt);
      print('n = $n');
      print('a = $a');
      print('b = $b');
      print('dt = $d');
      if (n.hour>6&&n.hour<18) {  //n.isAfter(a) && n.isBefore(b) || n.isAtSameMomentAs(a)
        img = 'images/sunny.jpg';
        ico = CupertinoIcons.sun_max;
      } else {
        img = 'images/night.jpg';
        ico = CupertinoIcons.moon_fill;
      }
    } else if (status == 'Thunderstorm') {
      img = 'images/Thunder.jpg';
      ico = Icons.cloud_circle;
    } else if (status == 'Snow') {
      img = 'images/snowy.jpg';
      ico = CupertinoIcons.snow;
    } else if (status == 'Atmosphere') {
      img = 'images/wind.jpg';
      ico = CupertinoIcons.wind;
    } else if (status == 'Clouds') {
      img = 'images/cloudy.jpeg';
      ico = CupertinoIcons.cloud_fill;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {}, //TODO
        ),
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: GestureDetector(
              onTap: () => print('Menu Clicked!'),
              child: IconButton(
                icon: Icon(
                  Icons.location_city,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  var result =Navigator.push(
                      context, MaterialPageRoute(builder: (_) => CityScreen()));
                },
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              img,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black87.withOpacity(0.5)),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 120,
                            ),
                            Text(
                              cityName,
                              style: TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato',
                              ),
                            ),
                            Text(
                              description,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
								fontFamily: 'Lato',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$temperature°C',
                              style: TextStyle(
                                  fontSize: 55,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,fontFamily: 'Lato',),
								  
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 80,
                              child: Row(
                                children: [
                                  Icon(
                                    ico,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    status,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
									  fontFamily: 'Lato',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 40),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.white30,
                        )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Wind',
                                style: TextStyle(
								fontFamily: 'Lato',
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                '$windSpeed',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white,fontFamily: 'Lato',),
                              ),
                              Text(
                                'm/s',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white,fontFamily: 'Lato',),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Rain',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white,fontFamily: 'Lato',),
                              ),
                              Text(
                                '0',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white,fontFamily: 'Lato',),
                              ),
                              Text(
                                'mm/1h',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white,fontFamily: 'Lato',),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Humidy',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white,fontFamily: 'Lato',),
                              ),
                              Text(
                                '$humidity',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white,fontFamily: 'Lato',),
                              ),
                              Text(
                                '%',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white,fontFamily: 'Lato',),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
