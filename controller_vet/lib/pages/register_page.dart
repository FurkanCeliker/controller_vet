import 'dart:convert';

import 'package:controller_vet/pages/il_secme_sayfasi.dart';
import 'package:controller_vet/pages/ilce_secme_sayfasi.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/il_model.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
 
  bool _evdeBakimSwitch = false;
  bool _petTaksiSwitch= false;
  bool _yediyirmidortSwitch = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: Text('Veteriner Kayıt Formu'),
      ),
      body: formWidget(),
    );
  }

  Form formWidget() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageUploadButton(),
            Padding(
              padding: const EdgeInsets.only(left: 155, top: 5),
              child: Container(
                child: Text('Görsel Yükleyin'),
              ),
            ),
            textFieldOlustur('Veteriner Klinik Adı', false,
                EdgeInsets.only(top: 25, right: 25, left: 25), false),
            textFieldOlustur('Mail Adresi', false,
                EdgeInsets.only(top: 10, right: 25, left: 25), false),
            textFieldOlustur(
                'Şifre',
                true,
                EdgeInsets.only(
                  top: 10,
                  left: 25,
                  right: 25,
                ),
                false),
            textFieldOlustur('Telefon Numarası', false,
                EdgeInsets.only(top: 10, right: 25, left: 25), true),
            textFieldOlustur('WhatsApp Hattı', false,
                EdgeInsets.only(top: 10, right: 25, left: 25), true),
            Padding(
              padding: EdgeInsets.only(top: 10, right: 25, left: 25),
              child: TextFormField(
                  obscureText: false,
                  keyboardType: TextInputType.multiline,
                  maxLines: 6,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12)),
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: 'Klinik Detay Bilgileri',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey)))),
            ),
           Row(
             children: [
               Padding(
                 padding: const EdgeInsets.only(left: 30,top: 15),
                 child: Text('Pet Taksi Hizmeti veriyor musunuz?'),
               ),
                Padding(
                  padding: const EdgeInsets.only(left: 90,top: 15),
                  child: CupertinoSwitch(
              value: _petTaksiSwitch,
              onChanged: (deger) {
                  setState(() {
                    _petTaksiSwitch = deger;
                  });
                  
              },
            ),
                ),
             ],
           ),
             Row(
             children: [
               Padding(
                 padding: const EdgeInsets.only(left: 30,top: 15),
                 child: Text('7/24 hizmet veriyor musunuz?'),
               ),
                Padding(
                  padding: const EdgeInsets.only(left: 120,top: 15),
                  child: CupertinoSwitch(
              value: _yediyirmidortSwitch,
              onChanged: (deger) {
                  setState(() {
                    _yediyirmidortSwitch = deger;
                  });
                  
              },
            ),
                ),
             ],
           ),
             Row(
             children: [
               Padding(
                 padding: const EdgeInsets.only(left: 30,top: 15),
                 child: Text('Evde Bakım hizmeti veriyor musunuz?'),
               ),
                Padding(
                  padding: const EdgeInsets.only(left: 75,top: 15),
                  child: CupertinoSwitch(
              value: _evdeBakimSwitch,
              onChanged: (deger) {
                  setState(() {
                    _evdeBakimSwitch = deger;
                  });
                  
              },
            ),
                ),
                
             ],
           ),
            Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 8.0),
                  child: ElevatedButton(
                    style:ElevatedButton.styleFrom(primary: _ilSecilmisMi ? Colors.blue.shade300: Colors.grey,shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),padding:EdgeInsets.symmetric(horizontal: 36, vertical: 20), ),
                    child: Center(
                      child: Text(
                        _secilenIl == null ? "İl Seçiniz" : "$_secilenIl",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: GoogleFonts.ebGaramond().toString(),
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
                    style:ElevatedButton.styleFrom(primary: _ilceSecilmisMi ? Colors.blue.shade300 : Colors.grey,shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),padding:  const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 20),) ,
                    child: Center(
                      child: Text(
                        _secilenIlce == null ? "İlçe Seçiniz" : "$_secilenIlce",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: GoogleFonts.ebGaramond().toString(),
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

                // Açık adres kısmı : 

                Padding(
              padding: EdgeInsets.only(top: 10, right: 25, left: 25,bottom: 10),
              child: TextFormField(
                  obscureText: false,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12)),
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: 'Açık adres bilgileri',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey)))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 50),
              child: Container(
              height: 60.h,
              width: 300.w,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Kayıt Ol',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ),
            ),
            SizedBox(height: 10,)
           
          ],
        ),
      ),
    );
  }

  Padding imageUploadButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 150),
      child: InkWell(
        splashColor: Colors.grey,
        onTap: () {},
        child: Ink(
          height: 100.h,
          width: 100.w,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('lib/assets/button.png'),
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }

  Padding textFieldOlustur(
      String text, bool sifreMi, EdgeInsets padding, bool telMi) {
    return Padding(
      padding: padding,
      child: TextFormField(
          obscureText: sifreMi,
          keyboardType: telMi ? TextInputType.number : null,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12)),
              labelStyle: TextStyle(color: Colors.grey),
              labelText: text,
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey)))),
    );
  }
}
