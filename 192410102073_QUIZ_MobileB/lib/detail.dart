// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:presentasi_quiz/menu.dart';
// ignore: unused_import
import 'package:presentasi_quiz/main.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Menu? _menu;

  int _jumlah = 0;

  void tambah() {
    setState(() {
      _jumlah++;
    });
  }

  void kurang() {
    setState(() {
      _jumlah--;
    });
  }

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    if (args.containsKey('menu')) {
      var menu = args['menu'];
      if (menu is Menu) {
        _menu = menu;
        if (_jumlah < 0) {
          _jumlah = _menu?.jumlah ?? -1;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Menu'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image(
                image: AssetImage('${_menu?.gambar}'),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 17,
              ),
              Text(
                _menu?.nama ?? 'ERROR',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 17,
              ),
              Text(
                'Rp ${_menu?.harga ?? 'ERROR'}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 17,
              ),
              Text('Deskripsi Produk', style: TextStyle(fontSize: 17)),
              SizedBox(
                height: 17,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        kurang();
                      },
                      icon: Icon(Icons.remove)),
                  Text('$_jumlah', style: TextStyle(fontSize: 15)),
                  IconButton(
                      onPressed: () {
                        tambah();
                      },
                      icon: Icon(Icons.add)),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop({'jumlah': _jumlah});
                  },
                  child: Text('Kirim'))
            ],
          )),
    );
  }
}
