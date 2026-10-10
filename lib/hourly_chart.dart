import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;


class HourlyChart extends StatefulWidget {

  final Map<String, dynamic>? data;
  final int from;

  const HourlyChart({
    super.key, 
    required this.data,
    required this.from,
  });

  @override
  State<HourlyChart> createState() => _HourlyChartState();
}

class _HourlyChartState extends State<HourlyChart> {

  String selected = 'Temp';

  Widget buildButton (String name, IconData icon) {

    return TextButton(

      onPressed: () {
        setState(() {
          selected = name;
        });
      }, 

      child: SizedBox(
        width: 85,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(
                color: selected == name ? Colors.white : Colors.white54,
                fontWeight: selected == name ? FontWeight.bold :FontWeight.normal,
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Icon(
                icon,
                color: selected == name ? Colors.white : Colors.white54,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getK () {

    switch (selected) {
     case 'Humidity':
        return 'relative_humidity_2m';
      case 'Pressure':
        return 'surface_pressure';
      case 'Wind':
        return 'wind_speed_10m';
      case 'Rain %':
        return 'precipitation_probability';
      default:
        return 'temperature_2m';
    }
  }

  List<double> getValues () {

    if (widget.data == null) {
      return [];
    }

    List<double> result = [];

    for (var i = widget.from; i < (widget.from + 24); i++) {
      
      result.add(widget.data!['hourly'][getK()][i].toDouble());
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {

    List<double> values = getValues();

    double top = 40;
    double bottom = 0;
    double step = 5;

    if (values.isNotEmpty) {

      double biggest = values.reduce(math.max);
      double smallest = values.reduce(math.min);

      if (selected == 'Humidity') {
        top = biggest;
        step = 10;
      } else if (selected == 'Pressure') {
        bottom = ((smallest / 5).floor()).toDouble();
        // bottom = 0;
        // top = ((biggest / 5).ceil() * 5 + 5).toDouble();
        top = biggest + 100;
        step = bottom;
      } else {
        top = biggest + 4;
      }

      // print(step);
    }

    return Column(

      children: [

        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(                         // top buttons
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              
              buildButton('Temp', Icons.thermostat),

              buildButton('Humidity', Icons.water_drop),

              buildButton('Pressure', Icons.compress),

              buildButton('Wind', Icons.air),

              buildButton('Rain %', Icons.umbrella),

            ],
          ),
      ),

      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: BarChart(
            BarChartData(

                minY: bottom,
                maxY: top,

                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: step,       // here we put the var
                      maxIncluded: false,
                      reservedSize: 50,
                    ),
                  ),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,        // not here
                      maxIncluded: false,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) {
                        String hour = value.toInt().toString().padLeft(2, '0');

                        return Text(
                          '$hour:00',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        );
                      },
                    ),
                  ), 
                ),


              barGroups: [
                for (int i = 0; i<values.length; i++)
                  BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: values[i],
                        color: Colors.white,
                        width: 8,
                      )
                    ],
                  ),
              ],
            )
          ),
        ),
      ),    
      ],
    );
  }
}