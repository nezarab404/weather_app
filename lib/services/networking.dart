import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'edc538b8e9e1234bd3768ad7d708cef9';

class NetworkHelper {
  double latitude;
  double longitude;
  NetworkHelper(this.latitude, this.longitude);


  Future getData() async {
    http.Response response = await http.get(Uri.http(
        'api.openweathermap.org',
        '/data/2.5/weather',
        {'lat': '$latitude', 'lon': '$longitude', 'appid': '$apiKey','units':'metric'}));

    if (response.statusCode == 200) {
      String data = response.body;
      return json.decode(data);
    } else {
      print(response.statusCode);
    }
  }



}
