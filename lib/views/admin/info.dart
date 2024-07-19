import 'package:flutter/material.dart';

import '../../components/drawer.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 200,
        backgroundColor: Colors.transparent,
        child: DrawerAdminScreen(),
      ),
      appBar: AppBar(
        title: Text('Info'),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          children: [
            Image.asset('assets/LOGO-HORIZONTAL.png'),
            SizedBox(
              height: 20,
            ),
            Text(
              'Malukussaleh Library',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Malikussaleh Library adalah aplikasi yang dibuat untuk membantu mahasiswa menemukan buku yang di inginkan secara mudah agar tidak banyak menghabiskan waktu untuk mencari buku yang tepat di perpustakaan Universitas Malikussaleh.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 150,
            ),
            Text(
              'Versi 1.0.0',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
