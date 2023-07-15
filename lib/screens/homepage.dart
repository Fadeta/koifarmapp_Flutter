import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var dataJson;
  int totalData = 0;
  void _api() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var response = await http
        .get(Uri.parse('http://localhost:1337/api/listkois'), headers: headers);

    dataJson = jsonDecode(response.body);
    print(dataJson["data"][0]["attributes"][0]);
    setState(() {
      totalData = dataJson["meta"]["pagination"]["total"];
    });
  }

  // var titleList = [
  //   "Kohaku",
  //   "Showa",
  //   "Tancho",
  //   "Goromo",
  //   "Utsuri",
  //   "Shiro",
  //   "Chagoi"
  // ];

  // // Description List Here
  // var descList = [
  //   "Total : 350",
  //   "Total : 200",
  //   "Total : 600",
  //   "Total : 500",
  //   "Total : 100",
  //   "Total : 50",
  //   "Total : 60"
  // ];

  // // Image Name List Here
  // var imgList = [
  //   "assets/images/kohaku1.jpg",
  //   "assets/images/showa1.jpg",
  //   "assets/images/tancho1.jpg",
  //   "assets/images/goromo1.jpg",
  //   "assets/images/utsuri1.jpg",
  //   "assets/images/shiro1.jpg",
  //   "assets/images/chagoi1.jpg"
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
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
                      //child: Image.asset(dataJson[index]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            dataJson["data"][index]["attributes"]["JenisKoi"],
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // ignore: sized_box_for_whitespace
                          Container(
                            width: 100,
                            child: Text(
                              dataJson["data"][index]["attributes"]["NamaKoi"],
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[500]),
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
        floatingActionButton: FloatingActionButton(onPressed: _api));
  }
}

// This is a block of Model Dialog
// showDialogFunc(dataJson) {
//   return showDialog(
//     context: dataJson,
//     builder: (context) {
//       return Center(
//         child: Material(
//           type: MaterialType.transparency,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.white,
//             ),
//             padding: const EdgeInsets.all(15),
//             height: 320,
//             width: MediaQuery.of(context).size.width * 0.7,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(5),
//                   child: Image.asset(
//                     dataJson,
//                     width: 200,
//                     height: 200,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   dataJson,
//                   style: const TextStyle(
//                     fontSize: 25,
//                     color: Colors.grey,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   // width: 200,
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       dataJson,
//                       maxLines: 3,
//                       style: TextStyle(fontSize: 15, color: Colors.grey[500]),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
