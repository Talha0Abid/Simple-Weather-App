import 'package:flutter/material.dart';

double numberOfDays (Map<String, dynamic>? data) {

  if (data == null) {

    return 0;

  }else{

    return (data['hourly']['time'].length/24);
  }
}

String theCurentDayConcast (int ful) {

  DateTime now = DateTime.now();

  String result;

  if (ful == 0){

    return "${now.year}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')}";
  }

  result = "${now.year}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')}T${now.hour.toString().padLeft(2,'0')}";
    
    // 2026-09-27 14:35:22       2026-09-25T00:00
  return result;
} 

String getWeatherDescription(String? weatherCode) {
  
  switch (weatherCode) {
    case '0':
      return 'Clear sky';
    case '1':
      return 'Mainly clear';
    case '2':
      return 'Partly cloudy';
    case '3':
      return 'Overcast';
    case '45':
      return 'Fog';
    case '48':
      return 'Depositing rime fog';
    case '51':
      return 'Light drizzle';
    case '53':
      return 'Moderate drizzle';
    case '55':
      return 'Dense drizzle';
    case '56':
      return 'Light freezing drizzle';
    case '57':
      return 'Dense freezing drizzle';
    case '61':
      return 'Slight rain';
    case '63':
      return 'Moderate rain';
    case '65':
      return 'Heavy rain';
    case '66':
      return 'Light freezing rain';
    case '67':
      return 'Heavy freezing rain';
    case '71':
      return 'Slight snowfall';
    case '73':
      return 'Moderate snowfall';
    case '75':
      return 'Heavy snowfall';
    case '77':
      return 'Snow grains';
    case '80':
      return 'Slight rain showers';
    case '81':
      return 'Moderate rain showers';
    case '82':
      return 'Violent rain showers';
    case '85':
      return 'Slight snow showers';
    case '86':
      return 'Heavy snow showers';
    case '95':
      return 'Thunderstorm';
    case '96':
      return 'Thunderstorm with slight hail';
    case '97':
      return 'Heavy thunderstorm';
    case '99':
      return 'Thunderstorm with heavy hail';
    default:
      return 'Unknown weather';
  }
}


IconData getWeatherIcon(String? weatherCode) {
  switch (weatherCode) {
    case '0':
    case '1':
      return Icons.wb_sunny;            // clear / mainly clear
    case '2':
      return Icons.wb_cloudy;           // partly cloudy
    case '3':
      return Icons.cloud;               // overcast
    case '45':
    case '48':
      return Icons.foggy;               // fog
    case '51':
    case '53':
    case '55':
    case '56':
    case '57':
      return Icons.grain;               // drizzle
    case '61':
    case '63':
    case '65':
    case '66':
    case '67':
    case '80':
    case '81':
    case '82':
      return Icons.water_drop;          // rain
    case '71':
    case '73':
    case '75':
    case '77':
    case '85':
    case '86':
      return Icons.ac_unit;             // snow
    case '95':
    case '96':
    case '97':
    case '99':
      return Icons.thunderstorm;        // thunderstorm
    default:
      return Icons.help_outline;        // unknown code
  }
}

String getShortMonth(String monthStr) {
  
  String result;

  switch (monthStr.trim()) {
    case '1':
    case '01':
      result = 'Jan';
      break;
    case '2':
    case '02':
      result = 'Feb';
      break;
    case '3':
    case '03':
      result = 'Mar';
      break;
    case '4':
    case '04':
      result = 'Apr';
      break;
    case '5':
    case '05':
      result = 'May';
      break;
    case '6':
    case '06':
      result = 'Jun';
      break;
    case '7':
    case '07':
      result = 'Jul';
      break;
    case '8':
    case '08':
      result = 'Aug';
      break;
    case '9':
    case '09':
      result = 'Sep';
      break;
    case '10':
      result = 'Oct';
      break;
    case '11':
      result = 'Nov';
      break;
    case '12':
      result = 'Dec';
      break;
    default:
      result = 'Invalid';
      break;
  }

  return result;
}
