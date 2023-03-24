import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrganicFarming extends StatefulWidget {
  const OrganicFarming({super.key});

  @override
  State<OrganicFarming> createState() => _OrganicFarmingState();
}

class _OrganicFarmingState extends State<OrganicFarming> {
  List farming = [];

  Future getFarming() async {
    var data = await DefaultAssetBundle.of(context)
        .loadString("assets/organic_farming.json");
    var result = jsonDecode(data);
    setState(() {
      farming = result['organic_farming'];
    });
  }

  @override
  void initState() {
    getFarming();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organic Farming"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff4C7845).withAlpha(70)),
                child: const Text(
                  "organic farming, agricultural system that uses ecologically based"
                  "pest controls and biological fertilizers derived largely from animal "
                  "and plant wastes and nitrogen-fixing cover crops. Modern organic farming"
                  "was developed as a response to the environmental harm caused by the use of "
                  "chemical pesticides and synthetic fertilizers in conventional agriculture,"
                  "and it has numerous ecological benefits.",
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: farming
                    .map((e) => Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff4C7845).withAlpha(70)),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    NetworkImage("${e['ref_image']}"),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("${e['farming_technique']}"),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                child: const Text("Read More"),
                                onPressed: () {
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) =>
                                          CupertinoActionSheet(
                                            title: Text(
                                                "${e['farming_technique']}"),
                                            message: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                      "${e['ref_image']}"),
                                                ),
                                                Text("\n${e['farming_usage']}"),
                                              ],
                                            ),
                                            actions: [
                                              CupertinoButton(
                                                  child: const Text("Done"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  })
                                            ],
                                          ));
                                },
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
