import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:newclimaapp/services/location.dart';
import 'package:newclimaapp/services/weather.dart';
import 'package:newclimaapp/utils/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/networking.dart';
import 'location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  WeatherModel weatherModel = new WeatherModel();
  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  getLocationData() async {
    dynamic weatherData = await weatherModel.getLocationWeather();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(locData: weatherData)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitWaveSpinner(
        color: Colors.white,
        size: 100.0,
      ),
    ));
  }
}
