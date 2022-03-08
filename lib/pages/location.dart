import 'package:flutter/material.dart';
import 'package:worldtimer/services/worldtime.dart';
import 'package:http/http.dart';


class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {

  List<String> states = [];
  // List<WorldTime> locations = [
  //   WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
  //   WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
  //   WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
  //   WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
  //   WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
  //   WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
  //   WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
  //   WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  // ];
  List<WorldTime> locations = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await this.setup();
      setState(() { });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
            itemCount: locations.length,
              itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    onTap: (){
                      update(index);
                      print(locations[index].location);
                    },
                    title: Text(locations[index].location),
                  ),
                );
              }
          )
      ),
    );
  }

  Future<void> setup() async {

    Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone'));
    states = response.body.substring(1,response.body.length - 1).split(",");
    for(int i=0; i<states.length;i++) {
      locations.add(WorldTime(location: states[i].replaceAll("\"", "").replaceAll("/", ""), flag: states[i].replaceAll("\"", ""), url: states[i].replaceAll("\"", "")));
    }
  }

  void update(int index) async {
    WorldTime item = locations[index];
    await item.wait();
    print(item.time);
    Navigator.pop(context, {
      'location': item.location,
      'flag': item.flag,
      'time': item.time,
      'daytime': item.dayTime
    });
  }
}
