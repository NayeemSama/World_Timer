import 'package:flutter/material.dart';
import 'package:worldtimer/pages/home.dart';
import 'package:worldtimer/pages/loading.dart';
import 'package:worldtimer/pages/location.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/loading',
    routes: {
      '/loading': (context)=> LoadingPage(),
      '/home': (context)=> Home(),
      '/location': (context)=> LocationPage(),
    },
  ));
}

