import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/constant.dart';

class SearchingAdminPage extends StatefulWidget {
  const SearchingAdminPage({super.key});

  @override
  State<SearchingAdminPage> createState() => _SearchingAdminPageState();
}

class _SearchingAdminPageState extends State<SearchingAdminPage> {
  List<String> data_result = [];
  static List<Map<String, dynamic>> result = [];

  void _searchResult(String value) {
    final searcResult = Constant.DATA_BUKU
        .where((element) =>
            element['judul'].toLowerCase().contains(value.toLowerCase()))
        .toList();

    result = {...searcResult}.toList();

    print('DATA SEARCHING NOW : $result');

    // result.map((e) => data_result[e]['judul']).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              labelText: 'Search by Judul',
              labelStyle: TextStyle(color: Colors.white),
              fillColor: Colors.white,
              suffixIcon: Icon(
                CupertinoIcons.search,
                color: Colors.white,
              )),
          onSubmitted: (value) {
            setState(() {});
            _searchResult(value);
          },
        ),
      ),
      body: result.isEmpty
          ? SizedBox(
              height: 400,
              width: double.maxFinite,
              child: Center(
                child: Text('Input data!'),
              ),
            )
          : ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, index) => InkWell(
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
                                result[index]['judul'].toString(),
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
                              Text(result[index]['penulis'].toString()),
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
                              Text(result[index]['tahun_terbit'].toString()),
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
                              Text(result[index]['posisi'].toString())
                            ],
                          ),
                        ),
                        btnOkOnPress: () {},
                      ).show();
                    },
                    child: ListTile(
                      title: Text('${result[index]['judul']}'),
                    ),
                  )),
    );
  }
}
