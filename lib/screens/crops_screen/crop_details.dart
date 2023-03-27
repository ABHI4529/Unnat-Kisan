import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/crop.dart';

class CropDetails extends StatefulWidget {
  CropDetails({super.key, this.header, this.data});
  String? header;
  Crops? data;

  @override
  State<CropDetails> createState() => _CropDetailsState();
}

class _CropDetailsState extends State<CropDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.header}"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("${widget.data?.cropImageUrl}"))),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${widget.data?.cropDescription}",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary.withAlpha(70)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Soil Details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: widget.data!.cropSoil!
                              .map((e) => Container(
                                    height: 350,
                                    width: 280,
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withAlpha(90)),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${e.soilName}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "\n${e.soilDescription}",
                                            style: const TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList()),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary.withAlpha(70)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Common Diseases",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: widget.data!.cropDiseases!
                              .map((e) => Container(
                                    width: 280,
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withAlpha(90)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${e.diseaseName}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10),
                                              width: double.maxFinite,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          "${e.diseaseImageUrl}")),
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withAlpha(90)),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ElevatedButton(
                                          child: const Text("More Details"),
                                          onPressed: () {
                                            showCupertinoModalPopup(
                                                context: context,
                                                builder:
                                                    (context) =>
                                                        CupertinoActionSheet(
                                                          title: Text(
                                                              "${e.diseaseName}"),
                                                          message: Column(
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            10),
                                                                width: double
                                                                    .maxFinite,
                                                                height: 200,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    image: DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: NetworkImage(
                                                                            "${e.diseaseImageUrl}")),
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary
                                                                        .withAlpha(
                                                                            90)),
                                                              ),
                                                              Text(
                                                                  "\n${e.diseaseCure}"),
                                                              const Text(
                                                                  "\nPossible Cures  - "),
                                                              Text(
                                                                  "${e.diseaseCure}")
                                                            ],
                                                          ),
                                                          actions: [
                                                            CupertinoButton(
                                                                child:
                                                                    const Text(
                                                                        "Done"),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                })
                                                          ],
                                                        ));
                                          },
                                        )
                                      ],
                                    ),
                                  ))
                              .toList()),
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
