import 'package:koifarm/API/network.dart';
import 'package:koifarm/API/koi_model.dart';
import 'package:koifarm/API/model.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final jenisController = TextEditingController();
  final jumlahController = TextEditingController();
  final imageController = TextEditingController();

  List<KOI> koilist = [];
  bool isLoading = true;

  Future<void> refreshData() async {
    setState(() {
      isLoading = true;
    });
    final result = await NetworkManager().getAll();
    koilist = result.data;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: koilist.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Show the formKoi dialog when an item is tapped.
              formKoi(koilist[index]);
            },
            child: Card(
              child: Row(
                children: <Widget>[
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      koilist[index].attributes.image,
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
                          koilist[index].attributes.jeniskoi,
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
                            koilist[index].attributes.jumlah.toString(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          formKoi(null);
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  void formKoi(KOI? data) async {
    if (data != null) {
      jenisController.text = data.attributes.jeniskoi;
      jumlahController.text = data.attributes.jumlah.toString();
      imageController.text = data.attributes.image;
    }
    bool confirm = false;
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(data == null ? 'ADD' : 'UPDATE'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextFormField(
                  controller: jenisController,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Jenis Koi',
                    labelStyle: TextStyle(
                      color: Colors.redAccent,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                      ),
                    ),
                    helperText: "Jenis Koi",
                  ),
                  onChanged: (value) {},
                ),
                TextFormField(
                  controller: jumlahController,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Jumlah Koi',
                    labelStyle: TextStyle(
                      color: Colors.redAccent,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                      ),
                    ),
                    helperText: "Jumlah Koi?",
                  ),
                  onChanged: (value) {},
                ),
                TextFormField(
                  controller: imageController,
                  maxLength: 100,
                  decoration: const InputDecoration(
                    labelText: 'Insert Image Link',
                    labelStyle: TextStyle(
                      color: Colors.redAccent,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                      ),
                    ),
                    helperText: "Link Image",
                  ),
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          actions: <Widget>[
            if (data != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                ),
                onPressed: () async {
                  await NetworkManager().deleteData(data.id);
                  await refreshData();
                  Navigator.pop(context);
                },
                child: const Text("Delete"),
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
              ),
              onPressed: () {
                confirm = true;
                Navigator.pop(context);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );

    if (confirm) {
      print("Confirmed!");
      listkoi request = listkoi(
        jenisController.text,
        int.parse(jumlahController.text),
        imageController.text,
      );
      if (data == null) {
        await NetworkManager().addData(request);
      } else {
        await NetworkManager().updateData(data.id, request);
      }

      jenisController.clear();
      jumlahController.clear();
      imageController.clear();

      await refreshData();
    }
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
