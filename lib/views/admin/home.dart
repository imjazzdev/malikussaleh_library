import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:malikussaleh_library/constants/constant.dart';
import 'package:malikussaleh_library/views/admin/edit_book.dart';
import 'package:malikussaleh_library/views/admin/search.dart';

import '../../components/drawer.dart';
import 'add_book.dart';

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({super.key});

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  bool isLoading = false;

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
    print('${Constant.DATA_BUKU}');
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchAdminPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 200,
        backgroundColor: Colors.transparent,
        child: DrawerAdminScreen(),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                // getDataBuku();
                fetchData();
              },
              icon: Icon(CupertinoIcons.search))
        ],
        toolbarHeight: 90, // Set this height
        flexibleSpace: Container(
            padding: EdgeInsets.only(top: 40, right: 15, left: 15, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                ),
                Image.asset(
                  'assets/LOGO-only.png',
                  height: 70,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
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
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('DATA_BUKU')
                  .snapshots(),
              builder: (context, snapshot) {
                return ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          AwesomeDialog(
                              context: context,
                              animType: AnimType.scale,
                              dialogType: DialogType.warning,
                              title: 'Pilih perintah yang diinginkan!',
                              desc: snapshot.data!.docs[index]['judul']
                                  .toString(),
                              btnOkText: 'UBAH',
                              btnOkOnPress: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditBookPage(
                                          id: snapshot.data!.docs[index].id,
                                          judul: snapshot
                                              .data!.docs[index]['judul']
                                              .toString(),
                                          penulis: snapshot
                                              .data!.docs[index]['penulis']
                                              .toString(),
                                          tahun_terbit: snapshot
                                              .data!.docs[index]['tahun_terbit']
                                              .toString(),
                                          posisi: snapshot
                                              .data!.docs[index]['posisi']
                                              .toString()),
                                    ));
                              },
                              btnCancelText: 'HAPUS',
                              btnCancelOnPress: () {
                                FirebaseFirestore.instance
                                    .collection('DATA_BUKU')
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete();
                              }).show();
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
                                snapshot.data!.docs[index]['penulis']
                                    .toString(),
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tahun Terbit : ${snapshot.data!.docs[index]['tahun_terbit'].toString()}',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['posisi']
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              }),
          isLoading == false
              ? const SizedBox()
              : const Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(),
                  ),
                )
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 30,
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('DATA_BUKU')
                  .snapshots(),
              builder: (context, snapshot) {
                return Text(
                  'Books : ${snapshot.data!.docs.length ?? 0}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade600,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddBookPage(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
