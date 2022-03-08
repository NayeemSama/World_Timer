import 'package:http/http.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class WorldTime{

  String location = '';
  String time = '';
  String flag = '';
  String url = '';
  var dayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> wait() async {

    // var url = 'https://jsonplaceholder.typicode.com/todos/1';
    try{
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      var datetime = data['datetime'];
      DateTime dateTime = DateTime.parse(datetime);
      var offset = data['utc_offset'].substring(1,3);
      var addsub = data['utc_offset'].substring(0,1);
      if(addsub=='+'){
        dateTime = dateTime.add(Duration(hours: int.parse(offset)));
      }
      else{
        dateTime = dateTime.subtract(Duration(hours: int.parse(offset)));
      }

      dayTime = dateTime.hour > 6 && dateTime.hour<20? true : false;
      print(dayTime);

      time = DateFormat.jm().format(dateTime);
    }
    catch(e){
      print('$e');
      time = 'could no get time';
    }

  }


}