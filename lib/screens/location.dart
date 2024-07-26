import 'package:flutter/material.dart';
import 'package:newclimaapp/screens/city.dart';
import 'package:newclimaapp/services/weather.dart';
import '../utils/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locData});
  final locData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = new WeatherModel();
  int? temperatureCelsius;
  String? cityName;
  String? weatherIcon;
  String? message;

  @override
  void initState() {
    print("LOC Widg Check::${widget.locData}");
    super.initState();

    getLocationInfo(widget.locData);
  }

  void getLocationInfo(dynamic locationDataInfo) {
    setState(() {
      if (locationDataInfo == null) {
        temperatureCelsius = 0;
        cityName = "Error";
        weatherIcon = "No Icon";
        message = "no data avai";
        return;
      }
      cityName = locationDataInfo['name']!;
      //to make temperature to be without decimal
      temperatureCelsius = locationDataInfo['main']['temp']!.toInt();
      message = weatherModel.getMessage(temperatureCelsius!);

      int condition = locationDataInfo['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      print("CHECK::$message");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var res = await weatherModel.getLocationWeather();
                      print("Pooja Res:: $res");
                      getLocationInfo(res);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityNameData = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
                      print("CIIITY::$cityNameData");
                      if (cityNameData != null) {
                        var cityDataInfo =
                            await weatherModel.getCityWeather(cityNameData);
                        getLocationInfo(cityDataInfo);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperatureCelsius°C',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
