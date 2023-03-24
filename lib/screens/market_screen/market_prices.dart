import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MarketPrices extends StatefulWidget {
  const MarketPrices({super.key});

  @override
  State<MarketPrices> createState() => _MarketPricesState();
}

class _MarketPricesState extends State<MarketPrices> {
  List marketPrices = [];
  Future getPrices() async {
    var data = await DefaultAssetBundle.of(context)
        .loadString("assets/market_prices.json");
    var result = jsonDecode(data);
    setState(() {
      marketPrices = result['market_prices'];
    });
  }

  @override
  void initState() {
    getPrices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Market Prices",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            headingRowColor: MaterialStateProperty.resolveWith(
                (states) => Theme.of(context).colorScheme.primary),
            columns: const [
              DataColumn(
                  label: Text(
                "Name",
                style: TextStyle(color: Colors.white),
              )),
              DataColumn(
                  label: Text(
                "Variety",
                style: TextStyle(color: Colors.white),
              )),
              DataColumn(
                  label: Text(
                "Max Price",
                style: TextStyle(color: Colors.white),
              )),
              DataColumn(
                  label: Text(
                "Min Price",
                style: TextStyle(color: Colors.white),
              )),
              DataColumn(
                  label: Text(
                "Avg Price",
                style: TextStyle(color: Colors.white),
              )),
              DataColumn(
                  label: Text(
                "Last Updated",
                style: TextStyle(color: Colors.white),
              )),
              DataColumn(
                  label: Text(
                "Price Trend",
                style: TextStyle(color: Colors.white),
              ))
            ],
            rows: marketPrices
                .map((e) => DataRow(cells: [
                      DataCell(Text("${e['crop_name']}")),
                      DataCell(Text("${e['variety']}")),
                      DataCell(Text("₹ ${e['maximum_price']}")),
                      DataCell(Text("₹ ${e['minimum_price']}")),
                      DataCell(Text("₹ ${e['average_price']}")),
                      DataCell(Text("${e['last_update']}")),
                      DataCell(e['status']
                          ? const Icon(
                              Icons.arrow_upward,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.arrow_downward,
                              color: Colors.green,
                            )),
                    ]))
                .toList()),
      ),
    );
  }
}
