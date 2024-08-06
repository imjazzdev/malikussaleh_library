import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:malikussaleh_library/models/book_model.dart';

import '../../components/drawer.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  var judul = TextEditingController();
  var penulis = TextEditingController();
  var tahun_terbit = TextEditingController();
  var posisi = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 200,
        backgroundColor: Colors.transparent,
        child: DrawerAdminScreen(),
      ),
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(25),
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Input Identitas Buku',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: judul,
                      decoration: InputDecoration(
                          hintText: 'Judul Buku', border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: penulis,
                      decoration: InputDecoration(
                          hintText: 'Penulis Buku', border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: tahun_terbit,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Tahun Terbit', border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: posisi,
                      decoration: InputDecoration(
                          hintText: 'Posisi Buku (ex: Rak 1/ Rak A / Rak A1)',
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    addBook();
                  },
                  child: Text(
                    'SIMPAN',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
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
    );
  }

  Future addBook() async {
    setState(() {
      isLoading = true;
    });
    final doc = await FirebaseFirestore.instance
        .collection('DATA_BUKU')
        .doc(judul.text);

    final book = Book(
        judul: judul.text,
        penulis: penulis.text,
        tahun_terbit: tahun_terbit.text,
        posisi: posisi.text);
    final json = book.toJson();
    await doc.set(json);

    // ignore: use_build_context_synchronously
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.success,
      desc: 'Data berhasil ditambahkan',
      dismissOnTouchOutside: false,
      btnOkOnPress: () {
        setState(() {
          isLoading = false;
          judul.clear();
          penulis.clear();
          tahun_terbit.clear();
          posisi.clear();
        });
      },
    ).show();
  }
}
