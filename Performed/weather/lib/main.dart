import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_api_client.dart';
import 'package:weather_app/views/additional.dart';
import 'package:weather_app/views/current_weather.dart';
import 'package:weather_app/models/weathermodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  String backgroundImage = '';
  final cityController = TextEditingController();

  Future<void> getData(String cityName) async {
    // Search city name
    data = await client.getCurrentWeather(cityName);

    // Set background image based on temperature value
    if (data != null) {
      double? temperature = data?.temp;
      if (temperature != null) {
        if (temperature > 20) {
          backgroundImage = 'assets/hot.jpg';
        } else {
          backgroundImage = 'assets/cold.jpg';
        }
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(backgroundImage),
            ),
          ),
          height: 750,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 75.0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: cityController,
                        decoration: const InputDecoration(
                          labelText: 'Enter city name',
                        ),
                        style: const TextStyle(
                          fontSize: 25.0, // Set the font size to 20.0
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          getData(cityController.text);
                        });
                      },
                      child: const Text('Get Weather'),
                    ),
                  ],
                ),
                if (data != null) ...[
                  const SizedBox(
                    height: 18.0,
                  ),
                  currentWeather(Icons.cloud_circle_sharp, "${data!.temp} \u2103",
                      "${data!.cityName}"),
                  const SizedBox(
                    height: 18.0,
                  ),
                  const Text(
                    "Additional Information",
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  additionalInformation("${data!.wind}m/s", "${data!.humidity}%",
                      "${data!.pressure}Pa", "${data!.feels_like} \u2103"),
                ] else if (backgroundImage.isNotEmpty) ...[
                  const SizedBox(
                    height: 18.0,
                  ),
                  const Text(
                    "City not found",
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ] else ...[
                  const SizedBox(
                    height: 18.0,
                  ),
                  const Text(
                    "Enter city name to get weather information",
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
