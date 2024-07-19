import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../components/drawer.dart';
import '../../constants/constant.dart';

class SearchMahasiswaPage extends StatelessWidget {
  const SearchMahasiswaPage({super.key});

  Future searchData(String param) async {
    List result = Constant.DATA_BUKU
        .where((element) => element['judul']
            .toString()
            .toLowerCase()
            .contains(param.toLowerCase()))
        .map((element) => element['judul'].toString())
        .toList();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   width: 200,
      //   backgroundColor: Colors.transparent,
      //   child: DrawerAdminScreen(),
      // ),
      appBar: AppBar(
        title: const Text('Search by Judul'),
      ),
      body: TypeAheadField<String>(
        suggestionsCallback: (search) async {
          return await searchData(search);
        },
        builder: (context, controller, focusNode) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
                controller: controller,
                focusNode: focusNode,
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                )),
          );
        },
        itemBuilder: (context, data) {
          return Material(
            elevation: 5,
            shadowColor: Colors.grey,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              title: Text(data.toString()),
            ),
          );
        },
        onSelected: (data) async {
          var databuku = await FirebaseFirestore.instance
              .collection('DATA_BUKU')
              .where('judul', isEqualTo: data)
              .get();

          print('INI DATA : ${databuku.docs[0]['judul']}');

          // ignore: use_build_context_synchronously
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
                        fontWeight: FontWeight.bold, color: Colors.amber),
                  ),
                  Text(
                    databuku.docs[0]['judul'].toString(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Penulis',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.amber),
                  ),
                  Text(databuku.docs[0]['penulis'].toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Tahun Terbit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.amber),
                  ),
                  Text(databuku.docs[0]['tahun_terbit'].toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Posisi',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.amber),
                  ),
                  Text(databuku.docs[0]['posisi'].toString())
                ],
              ),
            ),
            btnOkOnPress: () {},
          ).show();
        },
      ),
    );
  }
}
