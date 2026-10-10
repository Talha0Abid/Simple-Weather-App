import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'libes.dart';
import 'dart:convert';
import 'hourly_chart.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {

  Map<String, dynamic>? data;

  int selectedDay = 0;

  String ?curentTime;

  IconData ?curentIcon;


  String ?curentWather;
  String ?curentLocation;
  String ?curentTemp;

  String ?curentHumidety;
  String ?curentPrusser;
  String ?curentRainChance;
  String ?curentWindSpeed;

  Timer? timer;
  int? lastHour = DateTime.now().hour;

  Future<void> getWather () async {

    final url  = Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=36.9&longitude=7.7667&hourly=temperature_2m,relative_humidity_2m,precipitation_probability,weather_code,surface_pressure,wind_speed_10m&timezone=auto');
    final resporns = await http.get(url);
    final tempData = jsonDecode(resporns.body);


    final resolte = ApiInformation(tempData).ThCurenDateInformation();

    setState(() {
      
      data = tempData;

      curentIcon = resolte.icon;
      // curentIcon = Icons.ice_skating_outlined;

      curentWather = resolte.weather_code;
      curentTime = resolte.time;
      curentLocation = resolte.timezone;
      curentTemp = resolte.temperature_2m;
      curentHumidety = resolte.relative_humidity_2m;
      curentPrusser = resolte.surface_pressure;
      curentRainChance = resolte.precipitation_probability;
      curentWindSpeed = resolte.wind_speed_10m;

    });

    // print(data?['hourly']['time'][167]);

  }

  void updateDisplayForIndex(int index) {
    final resolte = ApiInformation(data).ThCurenDateInformation(index: index);
    
    setState(() {
      curentIcon = resolte.icon;
      curentWather = resolte.weather_code;
      curentTime = resolte.time;
      curentLocation = resolte.timezone;
      curentTemp = resolte.temperature_2m;
      curentHumidety = resolte.relative_humidity_2m;
      curentPrusser = resolte.surface_pressure;
      curentRainChance = resolte.precipitation_probability;
      curentWindSpeed = resolte.wind_speed_10m;
    });
  }

  @override
  void initState () {
    super.initState();
    getWather();

    timer = Timer.periodic(const Duration(minutes: 1), (t){

      int newHour = DateTime.now().hour;

      if (newHour != lastHour) {
        lastHour = newHour;
        getWather();
      }
    });

  }

  @override
  void dispose () {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [ 

          SizedBox.expand(       // the backgroind
            child: Image.asset(
              'assets/tes.jpg',
             fit: BoxFit.cover,
            ),
          ),

          Container(
            color: Colors.black.withOpacity(0.35),
          ),

          Positioned(
            top: 20,
            left: 0,
            right: 0,

            child: Center(
              child: Opacity(
                opacity: 0.75,
                child: Text(
                  '${curentTime}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          
          Column(
            children: [
          
              Padding(
                padding: const EdgeInsets.all(30),

                child: Row(          // the top part
                  children: [
                    
                    
                    Column(             // the fist part in the left that contane the annaba....
                      crossAxisAlignment: CrossAxisAlignment.start,
                    
                      children: [
                    
                        Icon(
                          curentIcon,
                          color: Colors.white,
                          size: 90,
                        ),
                    
                        const SizedBox(height: 4),
                    
                        SizedBox(
                          width: 170,
                          
                          child: Text(
                            '${curentWather}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    
                        Text(
                          '${curentLocation}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                    
                        const SizedBox(height: 20,),
                    
                        Text(
                          '${curentTemp}°C',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),    
                    
                        const SizedBox(height: 6,),
                    
                        const Row (
                          children: [
                    
                            Icon(
                              Icons.handshake,
                              color: Colors.white,
                            ),
                    
                            SizedBox(height: 4,),
                    
                            Text(
                              'Hola',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                    
                      ],
                    ),
                    
                    
                    Expanded(          // chart in the midel 

                      child: Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Container(
                          height: 300,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white54),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          
                          child: HourlyChart(data: data, from: selectedDay*24,),
                        ),
                      ),
                    ),
                    
                    Column(             // the seconde paert this is in the right 
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: [
                        
                        const Text(
                          'Humidity',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                
                        Text(
                          '${curentHumidety}%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold, 
                          ),
                        ),
                
                        const SizedBox(height: 25,),
                
                        const Text(
                          'Prusser',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                
                        Text(
                          '${curentPrusser} hPA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        const SizedBox(height: 25,),
                
                        const Text(
                          'Rian chance',
                
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                
                        Text(
                          '${curentRainChance}%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                
                        const SizedBox(height: 25,),
                
                        const Text(
                          'Wind speed',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                
                        Text(
                          '${curentWindSpeed} km/h',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                
                      ],
                    )
                  
                  ],
                ),
              ),
          
              // const Spacer(),
          
              DelingWithDesplay(
                data: data, 
                selectedDay: selectedDay,
                onDaySelected: (index) {
                  setState(() => selectedDay = index ~/ 24);
                  updateDisplayForIndex(index);
                },
              ),
          
              const SizedBox(height: 25,),
          
            ],
          ),
        
        
        ],
      ),
    );
  }
}
