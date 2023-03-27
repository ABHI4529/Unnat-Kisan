import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/client.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<Client> getUserData() async {
    final dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/client.json");
    var userData = file.readAsStringSync();
    var client = Client.fromJson(jsonDecode(userData));
    return client;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Profile"),
      ),
      body: FutureBuilder(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const CircularProgressIndicator();
            }
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff4C7845).withAlpha(70)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            child: Icon(
                              Iconsax.user,
                              size: 30,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            " ${snapshot.data?.fullName}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color(0xff4C7845).withAlpha(100)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${snapshot.data?.mailId}"),
                                  const Icon(Icons.mail)
                                ],
                              )),
                          Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color(0xff4C7845).withAlpha(100)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("+91 ${snapshot.data?.phoneNumber}"),
                                  const Icon(Icons.call)
                                ],
                              )),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text("Delete Account ?\n\n"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              child: const Text("No"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ElevatedButton(
                                              child: const Text("Delete"),
                                              onPressed: () async {
                                                final prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                await prefs
                                                    .clear()
                                                    .then((value) => exit(1));
                                              },
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                      },
                      child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff4C7845).withAlpha(100)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Delete Account"),
                              Icon(Icons.delete)
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text("Logout ?\n\n"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              child: const Text("No"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ElevatedButton(
                                              child: const Text("Yes"),
                                              onPressed: () async {
                                                final prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                await prefs
                                                    .clear()
                                                    .then((value) => exit(1));
                                              },
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                      },
                      child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff4C7845).withAlpha(100)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Logout"),
                              Icon(Icons.logout)
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
