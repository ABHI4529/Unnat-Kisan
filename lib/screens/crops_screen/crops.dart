import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unnatkisan/screens/crops_screen/crop_details.dart';

import '../../model/crop.dart';

class Crops_Screen extends StatefulWidget {
  Crops_Screen({super.key, required this.selectedCrop});
  List<Crops> selectedCrop;

  @override
  State<Crops_Screen> createState() => _CropsState();
}

class _CropsState extends State<Crops_Screen> {
  List<Crops> selectedCrops = [];
  List<Crops> crops = [];

  Future getCrops() async {
    var data = await DefaultAssetBundle.of(context)
        .loadString("assets/Crop_Data.json");
    var result = jsonDecode(data);
    var _crops = Crop.fromJson(result);
    setState(() {
      crops = _crops.crops!;
    });
  }

  Future saveCrops() async {
    final dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/myCrops.json");
    var myCrop = Crop(crops: selectedCrops);
    file.writeAsStringSync(jsonEncode(myCrop));
    Navigator.pop(context);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Crops Saved")));
  }

  @override
  void initState() {
    super.initState();
    getCrops();
    if (widget.selectedCrop.isEmpty) {
      null;
    } else {
      setState(() {
        selectedCrops = widget.selectedCrop;
      });
    }
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
                                          NetworkImage("${e.cropImageUrl}"),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text("${e.cropName}")
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
                                          title: Text("${e.cropName}"),
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
                                                        image: NetworkImage(
                                                            "${e.cropImageUrl}"))),
                                              ),
                                              Text("${e.cropDescription}")
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
                                                              header:
                                                                  "${e.cropName}",
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
                                          NetworkImage("${e.cropImageUrl}"),
                                    ),
                                    Text("${e.cropName}")
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
          onPressed: () {
            saveCrops();
          },
          child: const Text("Done"),
        ),
      ),
    );
  }
}
