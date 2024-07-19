import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:malikussaleh_library/views/admin/add_book.dart';
import 'package:malikussaleh_library/views/admin/info.dart';
import 'package:malikussaleh_library/views/admin/search.dart';
import 'package:malikussaleh_library/views/signin.dart';

import '../views/admin/home.dart';

class DrawerAdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: const Alignment(0.0, 0.1),
          colors: [Colors.white.withOpacity(0.8), Colors.white], //
        ),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Image(
              image: AssetImage('assets/LOGO-only.png'),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeAdminPage(),
                  ));
            },
          ),
          // ListTile(
          //   title: const Text('Search'),
          //   onTap: () {
          //     Navigator.pushReplacement(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const SearchAdminPage(),
          //         ));
          //   },
          // ),
          ListTile(
            title: const Text('Add book'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddBookPage(),
                  ));
            },
          ),
          ListTile(
            title: const Text('Info'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoPage(),
                  ));
            },
          ),
          // ListTile(
          //   title: const Text('Keranjang'),
          //   onTap: () {
          //     Navigator.pushReplacement(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => Keranjang(),
          //         ));
          //   },
          // ),
          const Divider(),
          ListTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Logout',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.logout,
                  color: Colors.red,
                )
              ],
            ),
            onTap: () {
              AwesomeDialog(
                      context: context,
                      animType: AnimType.scale,
                      dialogType: DialogType.question,
                      title: 'Yakin ingin Logout?',
                      btnOkOnPress: () {
                        Phoenix.rebirth(context);
                      },
                      btnCancelOnPress: () {})
                  .show();
            },
          ),
        ],
      ),
    );
  }
}
