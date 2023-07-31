import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  @override
  void initState() {
    super.initState();
    _api();
  }

  var dataJson;
  int totalData = 0;
  void _api() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var response = await http.get(Uri.parse('http://localhost:1337/api/items'),
        headers: headers);
    dataJson = jsonDecode(response.body);
    print(dataJson["data"][0]["attributes"][0]);
    setState(() {
      totalData = dataJson["meta"]["pagination"]["total"];
    });

    List<dynamic> data = [];
    bool isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Center(
          child: Text(
            'Recommendations',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          // Banner at the top
          Container(
            height: 150,
            color: Colors.lightBlueAccent,
            child: const Center(
              child: Text(
                'Banner',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // ListView for the list of items
          Expanded(
            child: ListView.builder(
              itemCount: totalData,
              itemBuilder: (data, index) {
                return GestureDetector(
                  // onTap: () {
                  //   showDialogFunc(
                  //       context, dataJson[index], dataJson[index], dataJson[index]);
                  // },
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        // ignore: sized_box_for_whitespace
                        Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            dataJson["data"][index]["attributes"]["image"],
                            width: 59,
                            height: 59,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                dataJson["data"][index]["attributes"]["nama"],
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // ignore: sized_box_for_whitespace
                              Container(
                                child: Text(
                                  dataJson["data"][index]["attributes"]
                                      ["deskripsi"],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // ignore: sized_box_for_whitespace
                              Container(
                                width: 100,
                                // ignore: prefer_interpolation_to_compose_strings
                                child: Text(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  "RP" +
                                      dataJson["data"][index]["attributes"]
                                              ["harga"]
                                          .toString(),
                                  style: const TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
