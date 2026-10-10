
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/Tools.dart';



class DelingWithDesplay extends StatelessWidget {

  final Map<String, dynamic>? data;
  final void Function(int index) onDaySelected;

  final int selectedDay;


  DelingWithDesplay({
    required this.data,
    required this.onDaySelected,
    required this.selectedDay,
  });

  Widget preccesTheFrameCard (int i) {

    String date = '${getShortMonth(data?['hourly']['time'][i*24].substring(5, 6))}${data?['hourly']['time'][i*24].substring(7, 10).replaceAll('-', '/')}';
    String temp = '${data?['hourly']['temperature_2m'][i*24]}';
    IconData icon = getWeatherIcon('${data?['hourly']['weather_code'][i*24]}');
    String rainChance = '${data?['hourly']['precipitation_probability'][i*24]}';

    return  FrameCard(
      date: date, 
      temp: temp, 
      icon: icon, 
      raiChance: rainChance, 
      isSelected: i == selectedDay,
      onTap: () => onDaySelected(i*24),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          for (var i=0; i<numberOfDays(data); i++) 
            preccesTheFrameCard(i),
            // const SizedBox(width: 15, ),                                         f = 0*0+23
        ],
      ),
    );
  }
}

class FrameCard extends StatelessWidget {

  // final Map<String, dynamic> ?data;
  // final int from;
  // final int to;

  final String date;    
  final IconData icon;
  final String temp;
  final String raiChance;

  final bool isSelected;


  final VoidCallback? onTap;
  

  const FrameCard({
    required this.date,
    required this.icon,
    required this.temp,
    required this.raiChance,
    required this.isSelected,
    required this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // print('Card clicked ${from}');
        onTap?.call();
      },

      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(140, 170),
        fixedSize: const Size(140, 170),
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),

        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 8,
            sigmaY: 8,
          ),

          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 140,
              height: 170,
            
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: isSelected ? 0.28 : 0.10),
                borderRadius: BorderRadius.circular(15),
            
                border: Border.all(
                  color: Colors.white.withValues(alpha: isSelected ? 0.90 : 0.12),
                  width: isSelected ? 2 : 1,
                ),
            
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                      ? Colors.white.withValues(alpha: 0.35)
                      : Colors.black.withValues(alpha: 0.20),
                    blurRadius: isSelected ? 22 : 15,
                    spreadRadius: isSelected ? 2 : 1,
                  ),
                ],
              ),
            
              child: Column(
                children: [
            
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      '${date}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
            
                  const SizedBox(height: 10),
            
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 80,
                  ),
            
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
                      children: [
            
                        Padding(
                          padding: const EdgeInsets.only(left: 11),
                          child: Text(
                            '${temp}°C',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
            
                        Padding(
                          padding: const EdgeInsets.only(right: 17),
                          child: Text(
                            '${raiChance}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
            
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class ApiInformation {

  final  Map<String, dynamic>? data;
  String ?curentWather;
  String ?curentLocation;
  String ?curentTemp;

  String ?curentHumidety;
  String ?curentPrusser;
  String ?curentRainChance;
  String ?curentWindSpeed;

  ApiInformation(this.data);

  ({IconData icon, String time, String timezone, String temperature_2m, String relative_humidity_2m, String precipitation_probability, String weather_code, String surface_pressure, String wind_speed_10m}) 
  
  ThCurenDateInformation ({int ?index}) {

    var i;

    if (index != null && !data?['hourly']['time'][index].startsWith(theCurentDayConcast(0)) ) {

      // print('${data?['hourly']['time'][index].startsWith(theCurentDayConcast(0))}');

      // print('${theCurentDayConcast(0)}');
      // print('${data?['hourly']['time'][index]}');

      i = index;
    }else{

      for (i = 0; i < data?['hourly']['time'].length; i++) {
      
        if (data?['hourly']['time'][i].contains(theCurentDayConcast(1))) {
        
          break ;
        }
      }
    }

    var tempTime = data?['hourly']['time'][i].toString() ?? 'null';
    tempTime = tempTime.replaceAll("T", "/");

    IconData theIcon = getWeatherIcon(data?['hourly']['weather_code'][i].toString());

    return (
      icon: theIcon,
      time: tempTime,
      timezone: data?['timezone'].toString() ?? 'null',
      weather_code: getWeatherDescription(data?['hourly']['weather_code'][i].toString()),
      temperature_2m: data?['hourly']['temperature_2m'][i].toString() ?? 'null',
      relative_humidity_2m: data?['hourly']['relative_humidity_2m'][i].toString() ?? 'null',
      surface_pressure: data?['hourly']['surface_pressure'][i].toString() ?? 'null',
      precipitation_probability: data?['hourly']['precipitation_probability'][i].toString() ?? 'null',
      wind_speed_10m: data?['hourly']['wind_speed_10m'][i].toString() ?? 'null',
  );
  }
}
