import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty? data : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);

    String bgImage = data['daytime']? 'day.png':'night.png';
    Color bgColor = data['daytime']? Colors.lightBlueAccent: Colors.indigo;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('HOME'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          )
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SafeArea(
              child: Column(
                children: [
                  FlatButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      print(result);
                      print('runned....');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'flag': result['flag'],
                          'daytime': result['daytime']
                        };
                        print(data['time']);
                      });
                    },
                    icon: Icon(Icons.add_location,
                      color: Colors.white,
                    ),
                    label: Text('Change',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(data['location'],
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(data['time'],
                    style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
