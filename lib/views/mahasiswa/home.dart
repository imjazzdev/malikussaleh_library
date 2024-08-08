import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/constant.dart';

class HomeMahasiswaPage extends StatefulWidget {
  const HomeMahasiswaPage({super.key});

  @override
  State<HomeMahasiswaPage> createState() => _HomeMahasiswaPageState();
}

class _HomeMahasiswaPageState extends State<HomeMahasiswaPage> {
  Future getDataFromFirestore() async {
    List<Map<String, dynamic>> dataList = [];

    // Referensi ke koleksi di Firestore
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('DATA_BUKU');

    try {
      // Ambil snapshot dari koleksi
      QuerySnapshot querySnapshot = await collectionRef.get();

      // Iterasi melalui dokumen-dokumen di snapshot
      for (var doc in querySnapshot.docs) {
        dataList.add(doc.data() as Map<String, dynamic>);
      }

      print('Data retrieved successfully.');
    } catch (e) {
      print('Error getting data: $e');
    }

    return dataList;
  }

  void fetchData() async {
    Constant.DATA_BUKU = await getDataFromFirestore();
    print('DATA BUKU:');
    print('${Constant.DATA_BUKU.runtimeType}');
    // ignore: use_build_context_synchronously
  }

  void _showAttention() async {
    await Future.delayed(Duration(milliseconds: 50));
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.warning,
      title: 'PERHATIAN!',
      titleTextStyle: TextStyle(
          color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
      desc: 'SETELAH BUKU DIBACA, MOHON DIKEMBALIKAN PADA RAK BUKU SEMULA!',
      btnOkOnPress: () {},
    ).show();
  }

  @override
  void initState() {
    _showAttention();
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90, // Set this height
        flexibleSpace: Container(
            padding:
                const EdgeInsets.only(top: 40, right: 15, left: 15, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(
                //   width: 40,
                // ),
                Image.asset(
                  'assets/LOGO-only.png',
                  height: 70,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Malikussaleh Library',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      'Make your book search easier',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ],
                )
              ],
            )),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('DATA_BUKU').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData != null) {
              return ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.info,
                          body: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Judul',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber),
                                ),
                                Text(
                                  snapshot.data!.docs[index]['judul']
                                      .toString(),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Penulis',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber),
                                ),
                                Text(snapshot.data!.docs[index]['penulis']
                                    .toString()),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Tahun Terbit',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber),
                                ),
                                Text(snapshot.data!.docs[index]['tahun_terbit']
                                    .toString()),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Posisi',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber),
                                ),
                                Text(snapshot.data!.docs[index]['posisi']
                                    .toString())
                              ],
                            ),
                          ),
                          btnOkOnPress: () {},
                        ).show();
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 25),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5,
                              )
                            ]),
                        child: Column(
                          children: [
                            Text(
                              snapshot.data!.docs[index]['judul'].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green.shade300,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data!.docs[index]['penulis'].toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                    'Tahun Terbit : ${snapshot.data!.docs[index]['tahun_terbit'].toString()}',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Text(
                                    snapshot.data!.docs[index]['posisi']
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
