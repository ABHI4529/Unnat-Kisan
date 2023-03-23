import 'package:flutter/material.dart';
import 'package:unnatkisan/crops_screen/crops.dart';
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
      body: [
        Dashboard(),
        Community(),
        Text("In Progress"),
        Text("In Progress")
      ][_selected],
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hey, Username"),
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
                child: const Text(
                  "A",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
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
                                  color: const Color(0xff4C7845).withAlpha(70)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
