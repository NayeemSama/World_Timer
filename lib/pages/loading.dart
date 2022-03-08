import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:worldtimer/services/worldtime.dart';


class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  
  @override
  void initState() {
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      // appBar: AppBar(
      //   title: Text('Location'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitRotatingCircle(
                color: Colors.white,
                size: 50,
              )
            ],
          )
      ),
    );
  }

  void setup() async {
    WorldTime object = WorldTime(location: 'location', flag: 'flag', url: 'America/Argentina/Salta');
    object.wait();
    await Future.delayed(Duration(seconds: 3), (){
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': object.location,
        'flag': object.flag,
        'time': object.time,
        'daytime': object.dayTime
      });
    });



    // print(object.time);

  }
}
