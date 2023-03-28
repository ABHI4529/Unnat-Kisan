import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:unnatkisan/model/chatbot.dart';
import 'package:unnatkisan/model/chatinterface.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final botFieldText = TextEditingController();
  List<ChatInterface> chatInterface = [];

  late BotChat chatbot;
  String helloText = "";

  Future<dynamic> getBot() async {
    var data =
        await DefaultAssetBundle.of(context).loadString("assets/chatbot.json");
    var result = jsonDecode(data);
    var _responces = BotChat.fromJson(result);

    setState(() {
      helloText = "${_responces.response}";
      chatbot = _responces;
    });
    return result;
  }

  @override
  void initState() {
    getBot().then((value) {
      chatInterface.add(ChatInterface(
          response: helloText, responseBy: "bot", isPressable: false));

      chatbot.solutions?.forEach((element) {
        chatInterface.add(ChatInterface(
          response: element.response,
          responseBy: "bot",
          isPressable: true,
        ));
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(10),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Help"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              children: chatInterface.map((e) {
                if (e.isPressable!) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.only(right: 70),
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.resolveWith(
                                (states) => const EdgeInsets.all(20))),
                        onPressed: () {
                          setState(() {
                            chatInterface.add(ChatInterface(
                              response: e.response!,
                              responseBy: "user",
                              isPressable: false,
                            ));
                          });




                          if (e.response! ==
                              "Information about various types of Farming") {
                            setState(() {
                              chatInterface.addAll([
                                ChatInterface(
                                    response:
                                        "Ley Farming : Farming is a very difficult in drylands because of water scarcity and lack of soil fertility ,so a method of farming was introduced to restore the fertility of the soil and was known as ley farming. In this method of farming ,grasses were grown in rotation with food grains to boost the nutrient level of the soil. It acts as an insurance against crop failures due to drought conditions.",
                                    responseBy: "bot",
                                    isPressable: false),
                                ChatInterface(
                                    response:
                                    "Contour Farming : The process of planting across a slope following its elevation contour lines.In this practice the ruts made by the plough are perpendicular to the slope rather than being parallel.Plants break the flow of water and prevent soil erosion,thereby making contour farming a sustainable way of farming.",
                                    responseBy: "bot",
                                    isPressable: false),
                                ChatInterface(
                                    response:
                                    "Hedgerow Intercropping : The practice of growing annual crops in between the rows of trees as an alternate method of fallow system is termed as hedge grow intercropping. The combination of trees and crops complement each other than competing .The trees create a favourable micro climate for the crops to survive by shielding them from drying winds.",
                                    responseBy: "bot",
                                    isPressable: false),
                              ]);
                            });
                            setState(() {
                              chatInterface.add(
                                ChatInterface(
                                    response: "Ask More",
                                    responseBy: "bot",
                                    isPressable: true),
                              );
                            });
                          } else {
                            for (var value in chatbot.solutions!.where(
                                (element) => element.response == e.response!)) {
                              value.solutions?.forEach((value) {
                                setState(() {
                                  chatInterface.addAll([
                                    ChatInterface(
                                      response: "${value.response}",
                                      responseBy: "bot",
                                      isPressable: false,
                                    ),
                                  ]);
                                });
                              });
                              setState(() {
                                chatInterface.add(
                                  ChatInterface(
                                      response: "Ask More",
                                      responseBy: "bot",
                                      isPressable: true),
                                );
                              });
                            }
                          }
                          if (e.response! == "Ask More") {
                            setState(() {
                              chatInterface.add(ChatInterface(
                                  response:
                                      "Sure! what would you like to know?",
                                  responseBy: "bot",
                                  isPressable: false));
                              chatbot.solutions?.forEach((element) {
                                chatInterface.add(ChatInterface(
                                  response: element.response,
                                  responseBy: "bot",
                                  isPressable: true,
                                ));
                              });
                            });
                          }
                          ;
                        },
                        child: Text("${e.response}")),
                  );
                }
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  alignment: e.responseBy == "bot"
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(70)),
                    child: Text("${e.response}"),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}
