

import 'dart:convert';

import 'package:flutter/material.dart';

class MythScreen extends StatefulWidget {
  const MythScreen({Key? key}) : super(key: key);

  @override
  State<MythScreen> createState() => _MythScreenState();
}

class _MythScreenState extends State<MythScreen> {

  List myths = [];

  Future getMyths() async {
    var data = await DefaultAssetBundle.of(context)
        .loadString("assets/myths.json");
    var result = jsonDecode(data);
    setState(() {
      myths = result['myths'];
    });
  }

  @override
  void initState() {
    getMyths();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Myths & Facts"),
      ),
      body: PageView(
        scrollDirection: Axis.vertical,
        children: myths.map((e) => Container(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red.shade700.withAlpha(180),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    "Myth : ${e['myth']}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withAlpha(150),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    "Fact : ${e['fact']}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text("Swipe Up For More",
                  style: TextStyle(
                    color: Colors.grey
                  ),
                )
              ],
            ),
          ),
        )).toList(),
      ),
    );
  }
}
