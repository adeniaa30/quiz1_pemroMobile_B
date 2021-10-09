import 'package:flutter/material.dart';
import 'package:presentasi_quiz/menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presentasi_quiz/detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keranjang Belanja',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Keranjang Belanja'),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (BuildContext ctx) => MyHomePage(
              title: 'Keranjang Belanja',
            ),
        '/detail': (BuildContext ctx) => Detail()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _menu = [
    Menu(
        nama: 'Nasi Goreng',
        jumlah: 0,
        harga: 10000,
        gambar: 'images/nasigoreng.jpg'),
    Menu(
        nama: 'Baso Aci',
        jumlah: 0,
        harga: 15000,
        gambar: 'images/basoaci.jpg'),
    Menu(
        nama: 'ketoprak',
        jumlah: 0,
        harga: 8000,
        gambar: 'images/ketoprak.jpg'),
    Menu(nama: 'Seblak', jumlah: 0, harga: 30000, gambar: 'images/seblak.jpg'),
    Menu(
        nama: 'Tahu Telor',
        jumlah: 0,
        harga: 30000,
        gambar: 'images/tahutelor.jpg'),
  ];

  void _handleNavResult(Object? result, Menu menu) {
    if (result != null) {
      var resultMap = result as Map<String, Object>;
      if (resultMap.containsKey('jumlah')) {
        var jumlah = resultMap['jumlah'];
        if (jumlah is int) {
          int _jumlah = jumlah;
          var index = _menu.indexOf(menu);
          if (index >= 0) {
            setState(() {
              _menu[index] = Menu(
                  nama: menu.nama,
                  jumlah: _jumlah,
                  harga: menu.harga,
                  gambar: menu.gambar);
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int total = 0;
    for (var i = 0; i < _menu.length; i++) {
      total += _menu[i].harga * _menu[i].jumlah;
    }
    var scaffold = Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          child: Column(
            children: <Widget>[
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: ListView(
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _menu.map((makanan) {
                          return Card(
                            margin: EdgeInsets.all(10.0),
                            elevation: 10,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                )),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Image(
                                  image: AssetImage(makanan.gambar),
                                  width: 150,
                                  height: 150,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      makanan.nama,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.balsamiqSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Jumlah : ${makanan.jumlah}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.balsamiqSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Jumlah : ${makanan.harga}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.balsamiqSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          var result =
                                              await Navigator.of(context)
                                                  .pushNamed('/detail',
                                                      arguments: {
                                                'menu': makanan,
                                              });

                                          _handleNavResult(result, makanan);
                                        },
                                        child: Text('Lihat Detail'))
                                  ],
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  )),
              Container(
                height: 70,
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rp $total',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
    return scaffold;
  }
}
