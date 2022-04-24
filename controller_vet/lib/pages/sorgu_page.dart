import 'dart:convert';

import 'package:controller_vet/model/il_model.dart';
import 'package:controller_vet/pages/il_secme_sayfasi.dart';
import 'package:controller_vet/pages/ilce_secme_sayfasi.dart';
import 'package:controller_vet/pages/listview_vet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/constants.dart';

class IlIlceSecimi extends StatefulWidget {
  @override
  _IlIlceSecimiState createState() => _IlIlceSecimiState();
}

class _IlIlceSecimiState extends State<IlIlceSecimi> {
  /// JSON yüklenmesinin tamamlanıp tamamlanmadığı kontrolu için
  bool _yuklemeTamamlandiMi = false;

  /// Sonuç il ve ilçe
  String? _secilenIl;
  String? _secilenIlce;

  /// Butonların rengini seçilip seçilmediğine göre değiştirmek için (zorunlu değil)
  bool _ilSecilmisMi = false;
  bool _ilceSecilmisMi = false;

  /// JSON'dan okuyacağımız "Il" nesnelerinin toplanacağı liste
  List<dynamic> _illerListesi = [];

  /// Il ve Ilce Secme Sayfalarına gönderirken tanımlayacağımız listeler
  List<String> _ilIsimleriListesi = [];
  List<String> _ilceIsimleriListesi = [];

  /// Il ve Ilce Secme Sayfalarından gelecek olan index değerleri, bunlar ile listelerden gereken Il ve Ilce adını alabileceğiz
  int? _secilenIlIndexi;
  int? _secilenIlceIndexi;
  bool petTaksiSwitch = false;
  bool yediYirmiDortSwitch = false;
  bool evdeBakimSwitch = false;
  GlobalKey<FormState> _formKey = GlobalKey();

  /// JSON'u okuyup içinden Il nesnelerini listede toplama
  Future<void> _illeriGetir() async {
    String jsonString = await rootBundle.loadString('json/il-ilce.json');

    final jsonResponse = json.decode(jsonString);

    _illerListesi = jsonResponse.map((x) => Il.fromJson(x)).toList();
  }

  /// Il nesnelerinden sadece il_adi değişkenlerini ayrı bir listede toplama
  void _ilIsimleriniGetir() {
    _ilIsimleriListesi = [];

    _illerListesi.forEach((element) {
      _ilIsimleriListesi.add(element.ilAdi);
    });

    setState(() {
      _yuklemeTamamlandiMi = true;
    });
  }

  /// Ilce seçimi için seçilen ile göre ilçeleri getirme
  void _secilenIlinIlceleriniGetir(String _secilenIl) {
    _ilceIsimleriListesi = [];
    _illerListesi.forEach((element) {
      if (element.ilAdi == _secilenIl) {
        element.ilceler.forEach((element) {
          _ilceIsimleriListesi.add(element.ilceAdi);
        });
      }
    });
  }

  Future<void> _ilSecmeSayfasinaGit() async {
    if (_yuklemeTamamlandiMi) {
      _secilenIlIndexi = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IlSecimiSayfasi(ilIsimleri: _ilIsimleriListesi),
        ),
      );
      _secilenIlceIndexi = null;
      _ilSecilmisMi = true;
      _secilenIl = _ilIsimleriListesi[_secilenIlIndexi!];
      _secilenIlinIlceleriniGetir(_illerListesi[_secilenIlIndexi!].toString());
      setState(() {});
    }
  }

  Future<void> _ilceSecmeSayfasinaGit() async {
    if (_ilSecilmisMi) {
      _secilenIlinIlceleriniGetir(_ilIsimleriListesi[_secilenIlIndexi!]);
      _secilenIlceIndexi = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              IlceSecmeSayfasi(ilceIsimleri: _ilceIsimleriListesi),
        ),
      );
      _ilceSecilmisMi = true;
      _secilenIlce = _ilceIsimleriListesi[_secilenIlceIndexi!];
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _illeriGetir().then((value) => _ilIsimleriniGetir());
  }

  @override
  Widget build(BuildContext context) {
    double genislik = Constants.getSizeWidth(context);
    double yukseklik = Constants.getSizeHeight(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 212, 230, 244),
      appBar: AppBar(
        title: Text(
          "Veteriner Arama",
          style: TextStyle(
            fontSize: 18,
            fontFamily: GoogleFonts.ebGaramond().toString(),
            color: Colors.white,
            shadows:const <Shadow>[
              Shadow(
                offset: Offset(1, 1),
                color: Colors.grey,
                blurRadius: 3,
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: _ilSecilmisMi ? Colors.blue.shade300 : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 36, vertical: 20),
                ),
                child: Center(
                  child: Text(
                    _secilenIl == null ? "İl Seçiniz" : "$_secilenIl",
                    style:const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1, 1),
                          color: Colors.grey,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                onPressed: () async {
                  await _ilSecmeSayfasinaGit();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 30.0, vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary:
                      _ilceSecilmisMi ? Colors.blue.shade300 : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 36, vertical: 20),
                ),
                child: Center(
                  child: Text(
                    _secilenIlce == null ? "İlçe Seçiniz" : "$_secilenIlce",
                    style:const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1, 1),
                          color: Colors.grey,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                onPressed: () async {
                  await _ilceSecmeSayfasinaGit();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.local_taxi),
               const Text('Pet Taksi Hizmeti     '),
                CupertinoSwitch(
                    value: petTaksiSwitch,
                    onChanged: (value) {
                      setState(() {
                        petTaksiSwitch = value;
                      });
                    })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               const Icon(Icons.home),
               const Text('Evde Bakım Hizmeti'),
                CupertinoSwitch(
                    value: evdeBakimSwitch,
                    onChanged: (value) {
                      setState(() {
                        evdeBakimSwitch = value;
                      });
                    })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.twenty_four_mp),
              const  Text('7/24 Açık Veteriner  '),
                CupertinoSwitch(
                    value: yediYirmiDortSwitch,
                    onChanged: (value) {
                      setState(() {
                        yediYirmiDortSwitch = value;
                      });
                    })
              ],
            ),
            Padding(
              padding: EdgeInsets.all(yukseklik * 0.1),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape:  RoundedRectangleBorder(
                          borderRadius:  BorderRadius.circular(20)),
                      fixedSize: Size(200.w, 60.h)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => ListviewVet(
                              evdeBakim: evdeBakimSwitch,
                              il: _secilenIl == null ? '' : _secilenIl!,
                              ilce: _secilenIlce == null ? '' : _secilenIlce!,
                              petTaksi: petTaksiSwitch,
                              yediYirmiDort: yediYirmiDortSwitch,
                            ))));
                  },
                  child:const Text(
                    'Veteriner Bul',
                    style: TextStyle(fontSize: 25),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
