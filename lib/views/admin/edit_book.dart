import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:malikussaleh_library/models/book_model.dart';

class EditBookPage extends StatefulWidget {
  final String judul, penulis, tahun_terbit, posisi;
  final String id;

  const EditBookPage(
      {super.key,
      required this.id,
      required this.judul,
      required this.penulis,
      required this.tahun_terbit,
      required this.posisi});

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  @override
  void initState() {
    judul.text = widget.judul;
    penulis.text = widget.penulis;
    tahun_terbit.text = widget.tahun_terbit;
    posisi.text = widget.posisi;
    super.initState();
  }

  var judul = TextEditingController();
  var penulis = TextEditingController();
  var tahun_terbit = TextEditingController();
  var posisi = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(25),
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Edit Identitas Buku',
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
                    updateBook(widget.id);
                  },
                  child: Text(
                    'UBAH',
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

  Future updateBook(String id) async {
    setState(() {
      isLoading = true;
    });
    final doc =
        await FirebaseFirestore.instance.collection('DATA_BUKU').doc(id);

    doc.update({
      'judul': judul.text,
      'penulis': penulis.text,
      'tahun_terbit': tahun_terbit.text,
      'posisi': posisi.text
    });

    // ignore: use_build_context_synchronously
    AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.success,
            desc: 'Data berhasil diubah',
            btnOkOnPress: () {
              Navigator.pop(context);
            },
            btnCancelOnPress: () {})
        .show();
  }
}
