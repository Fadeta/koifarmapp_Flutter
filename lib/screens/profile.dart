import 'package:flutter/material.dart';
import 'package:koifarm/models/constans.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(child: Text('My Profile')),
        actions: [
          InkWell(
            onTap: () {
              //hehe
            },
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Icon(Icons.info),
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.red,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 230,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Fadeta Ilhan',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text('fadetaig28@gmail.com',
                          style: Theme.of(context).textTheme.titleSmall),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                KoiDetailRow(title: 'Kolam Satu', value: '1200 Ekor'),
                KoiDetailRow(title: 'Tanggal Benih', value: '31-08-2023'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                KoiDetailRow(title: 'Kolam Dua', value: '1000 Ekor'),
                KoiDetailRow(title: 'Tanggal Benih', value: '29-10-2023'),
              ],
            ),
            const KoiDetailColumn(title: 'Farm :', value: 'Wahana Koi Farm'),
            const KoiDetailColumn(title: 'Alamat :', value: 'Talun, Blitar'),
            const KoiDetailColumn(title: 'Special Koi :', value: 'Showa'),
            const KoiDetailColumn(title: 'Nomor HP :', value: '+628128909818'),
          ],
        ),
      ),
    );
  }
}
