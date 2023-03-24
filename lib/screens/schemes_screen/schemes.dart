import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Schemes extends StatefulWidget {
  const Schemes({super.key});

  @override
  State<Schemes> createState() => _SchemesState();
}

class _SchemesState extends State<Schemes> {
  List schemes = [];

  Future getSchemes() async {
    var data =
        await DefaultAssetBundle.of(context).loadString("assets/schemes.json");
    var result = jsonDecode(data);
    setState(() {
      schemes = result['schemes'];
    });
  }

  @override
  void initState() {
    getSchemes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schemes"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
              children: schemes
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
                                  NetworkImage("${e['reference_imageUrl']}"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("${e['scheme_name']}"),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              child: const Text("Read More"),
                              onPressed: () {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => CupertinoActionSheet(
                                          title: Text("${e['scheme_name']}"),
                                          message: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                    "${e['reference_imageUrl']}"),
                                              ),
                                              Text(
                                                  "\n${e['schemes_benefits']}"),
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
                  .toList()),
        ),
      ),
    );
  }
}
