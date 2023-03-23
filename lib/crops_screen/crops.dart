import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unnatkisan/crops_screen/crop_details.dart';

class Crops extends StatefulWidget {
  const Crops({super.key});

  @override
  State<Crops> createState() => _CropsState();
}

class _CropsState extends State<Crops> {
  List selectedCrops = [];
  List crops = [];

  Future getCrops() async {
    var data = await DefaultAssetBundle.of(context)
        .loadString("assets/Crop_Data.json");
    var result = jsonDecode(data);
    setState(() {
      crops = result['crops'];
    });
  }

  @override
  void initState() {
    super.initState();
    getCrops();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Crops"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: const Color(0xff4C7845).withAlpha(50),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Selected Crops",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: selectedCrops
                            .map(
                              (e) => Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 132,
                                width: 130,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color(0xff4C7845).withAlpha(70)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedCrops.remove(e);
                                              crops.add(e);
                                            });
                                          },
                                          child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 5, right: 5),
                                              child: const Icon(
                                                  Icons.remove_circle)),
                                        )),
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          NetworkImage(e['crop_imageUrl']),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(e['crop_name'])
                                  ],
                                ),
                              ),
                            )
                            .toList()),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 180,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      children: crops
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => CupertinoActionSheet(
                                          title: Text(e['crop_name']),
                                          message: Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(e[
                                                            'crop_imageUrl']))),
                                              ),
                                              Text(e['crop_description'])
                                            ],
                                          ),
                                          actions: [
                                            CupertinoButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CropDetails(
                                                              data: e,
                                                              header: e[
                                                                  'crop_name'],
                                                            )));
                                              },
                                              child: const Text("More Info"),
                                            ),
                                            CupertinoButton(
                                              onPressed: () {
                                                setState(() {
                                                  selectedCrops.add(e);
                                                  crops.remove(e);
                                                });
                                                Navigator.pop(context);
                                              },
                                              child:
                                                  const Text("Add to my crops"),
                                            )
                                          ],
                                          cancelButton: CupertinoButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                        ));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 132,
                                width: 130,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color(0xff4C7845).withAlpha(70)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          NetworkImage(e['crop_imageUrl']),
                                    ),
                                    Text(e['crop_name'])
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(
                      height: 70,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 150,
        child: FloatingActionButton(
          onPressed: () {},
          child: const Text("Done"),
        ),
      ),
    );
  }
}
