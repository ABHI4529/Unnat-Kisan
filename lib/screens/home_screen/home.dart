import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unnatkisan/crops_screen/crops.dart';
import 'package:unnatkisan/model/client.dart';
import 'package:unnatkisan/screens/equipment_screen/equipment.dart';
import 'package:unnatkisan/screens/farming_screen/organic_farming.dart';
import 'package:unnatkisan/screens/market_screen/market_prices.dart';
import 'package:unnatkisan/screens/profile_screen/profile.dart';
import 'package:unnatkisan/screens/schemes_screen/schemes.dart';
import 'package:unnatkisan/screens/search_screen/community.dart';

class HomeStruct extends StatefulWidget {
  const HomeStruct({super.key});

  @override
  State<HomeStruct> createState() => _HomeStructState();
}

class _HomeStructState extends State<HomeStruct> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          navigationBarTheme: NavigationBarThemeData(
              indicatorColor: const Color(0xff4C7845).withAlpha(100),
              backgroundColor: const Color(0xff4C7845).withAlpha(50))),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [Dashboard(), Community(), Schemes(), Profile()][_selected],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_filled), label: "Home"),
          NavigationDestination(
              icon: Icon(Icons.chat_bubble_rounded), label: "Community"),
          NavigationDestination(icon: Icon(Icons.book), label: "Schemes"),
          NavigationDestination(
              icon: Icon(Icons.account_box), label: "Profile"),
        ],
        selectedIndex: _selected,
        onDestinationSelected: (val) {
          setState(() {
            _selected = val;
          });
        },
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<Client> getUserData() async {
    final dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/client.json");
    var userData = file.readAsStringSync();
    var client = Client.fromJson(jsonDecode(userData));
    return client;
  }

  Map<String, dynamic> weatherData = {
    "main": {
      "temp": 0,
    },
    "name": "",
    "weather": [
      {
        "main": "",
      }
    ],
  };

  Future<Map<String, dynamic>> getWeather(String city) async {
    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=bda39e37cd4ec314ff479d12a3b320bb";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final data = response.body;
    final jsonData = jsonDecode(data);
    weatherData = jsonData;
    return weatherData;
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const CircularProgressIndicator();
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("Hey, ${snapshot.data?.fullName}"),
              actions: [
                TextButton(
                    onPressed: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: const Color(0xff4C7845),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "${snapshot.data?.fullName}".substring(0, 1),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: 200,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: const Color(0xff4C7845).withAlpha(50),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Your Crops",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Crops()));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xff4C7845)
                                            .withAlpha(70)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.add),
                                        Text("Add a Crop")
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: getWeather("${snapshot.data?.city}"),
                        builder: (context, shots) {
                          if (snapshot.hasError) {
                            return const CircularProgressIndicator();
                          }
                          return Container(
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xff4C7845).withAlpha(70)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "${shots.data?['main']['temp']}°C",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${shots.data?['name']}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${shots.data?['weather'][0]['main']}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: GridView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Equipment()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff4C7845).withAlpha(70)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.agriculture),
                                  Text("Advance Equipment")
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrganicFarming()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff4C7845).withAlpha(70)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Iconsax.hospital),
                                  Text("Oragnic Farming")
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MarketPrices()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff4C7845).withAlpha(70)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Iconsax.shop),
                                  Text("Market Pricing")
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Schemes()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff4C7845).withAlpha(70)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Iconsax.shield_search),
                                  Text("Goverment Schemes")
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
