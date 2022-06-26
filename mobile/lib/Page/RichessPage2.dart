import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/Page/RegisterScrenn.dart';
import 'package:mobile/Page/pages.dart';
import 'package:mobile/models/RichesExpend_model.dart';
import 'package:mobile/models/RichesHarta_model.dart';
import 'package:mobile/models/RichesPendapatan_mode.dart';
import 'package:mobile/models/RichesUtang_model.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:mobile/providers/harta_provider.dart';
import 'package:mobile/providers/pendapatan_provider.dart';
import 'package:mobile/providers/pengeluaran_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../providers/hutang_provider.dart';

class RichesPage2 extends StatefulWidget {
  RichesPage2({Key? key}) : super(key: key);

  @override
  State<RichesPage2> createState() => _RichesPageState();
}

class _RichesPageState extends State<RichesPage2> {
  // final RichesHartaModel hartaRemove =
  //     RichesHartaModel(harta: '', id: 0, rupiah: 0);
  // _RichesPageState(this.hartaRemove);

  getInit() async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    await Provider.of<PendapatanProvider>(context, listen: false)
        .getPendapatans(authProvider.user.token);

    await Provider.of<PengeluaranProvider>(context, listen: false)
        .getPengeluarans(authProvider.user.token);
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    getInit();
  }

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;

    final bodyHeight = sizeHeight - MediaQuery.of(context).padding.top;
    PendapatanProvider pendapatanProvider =
        Provider.of<PendapatanProvider>(context);
    PengeluaranProvider pengeluaranProvider =
        Provider.of<PengeluaranProvider>(context);

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xff7F3DFF),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 238, 238, 238),
                        blurRadius: 10,
                        spreadRadius: 5)
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 30, right: 20, bottom: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Transaction',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                child: const Text(
                  'Pendapatan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Column(
                children: pendapatanProvider.pendapatans
                    .map<Widget>((pendapatan) => PendapatanBox(pendapatan))
                    .toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                child: const Text(
                  'Pengeluaran',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Column(
                children: pengeluaranProvider.pengeluarans
                    .map<Widget>((pengeluaran) => PengeluaranBox(pengeluaran))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PengeluaranBox(RichesExpendModel pengeluaran) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;
    final bodyHeight = sizeHeight - MediaQuery.of(context).padding.top;

    return SizedBox(
      height: bodyHeight * 0.1,
      child: ListView.builder(
        itemCount: 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Row(
          children: [
            Container(
              width: 250,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
              // width: sizeWidth * 0.4,
              // color: Colors.amber,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pengeluaran.pengeluaran,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 150,
              child: Row(
                children: [
                  Container(
                    // color: Colors.red,
                    // width: sizeWidth * 0.4,
                    child: Text(
                      'Rp. ' + pengeluaran.rupiah.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 218, 3, 3),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.expand_more_outlined,
                    color: Color.fromARGB(255, 160, 11, 0),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  PendapatanBox(RichesPendapatanModel Pendapatan) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;
    final bodyHeight = sizeHeight - MediaQuery.of(context).padding.top;

    return SizedBox(
      height: bodyHeight * 0.1,
      child: ListView.builder(
        itemCount: 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Row(
          children: [
            Container(
              width: 250,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
              // width: sizeWidth * 0.4,
              // color: Colors.amber,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Pendapatan.penghasilan,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 150,
              child: Row(
                children: [
                  Container(
                    // color: Colors.red,
                    // width: sizeWidth * 0.4,
                    child: Text(
                      'Rp. ' + Pendapatan.rupiah.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 81, 199, 85),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Icon(
                      Icons.expand_less_rounded,
                      color: Color.fromARGB(255, 3, 158, 8),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // deleteData(harta.id.toString(), token);
                    // hartaProvider.removeHarta(hartaRemove.id);
                  },
                  child: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
