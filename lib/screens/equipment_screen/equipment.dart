import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Equipment extends StatefulWidget {
  const Equipment({super.key});

  @override
  State<Equipment> createState() => _EquipmentState();
}

class _EquipmentState extends State<Equipment> {
  List equipment = [];

  Future getFarming() async {
    var data = await DefaultAssetBundle.of(context)
        .loadString("assets/equipments.json");
    var result = jsonDecode(data);
    setState(() {
      equipment = result['equipments'];
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
        title: const Text("Advance Equipments"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          child: Column(
            children: equipment
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
                                NetworkImage("${e['product_imageUrl']}"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("${e['product_name']}"),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("${e['price_range']}"),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            child: const Text("Read More"),
                            onPressed: () {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => FramingDetails(
                                        e: e,
                                      ));
                            },
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class FramingDetails extends StatefulWidget {
  FramingDetails({super.key, this.e});
  dynamic e;

  @override
  State<FramingDetails> createState() => _FramingDetailsState();
}

class _FramingDetailsState extends State<FramingDetails> {
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text("${widget.e['product_name']}"),
      message: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network("${widget.e['product_imageUrl']}"),
          ),
          Text("\n${widget.e['product_usage']}\n"),
          Column(
            children: List.from(widget.e['benefits'])
                .map((v) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          child: const CircleAvatar(
                            radius: 3,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 5),
                            width: MediaQuery.of(context).size.width - 108,
                            child: Text(
                              "$v",
                              textAlign: TextAlign.start,
                            ))
                      ],
                    ))
                .toList(),
          )
        ],
      ),
      actions: [
        CupertinoButton(
            child: const Text("Done"),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }
}
