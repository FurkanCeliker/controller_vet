import 'dart:convert';
import 'dart:io';

import 'package:controller_vet/pages/hosgeldin_page.dart';
import 'package:controller_vet/pages/il_secme_sayfasi.dart';
import 'package:controller_vet/pages/ilce_secme_sayfasi.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../bloc/auth_bloc.dart';
import '../model/il_model.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController vetNameController = TextEditingController();
  TextEditingController petTaksiController = TextEditingController();
  TextEditingController evdeBakimController = TextEditingController();
  TextEditingController vetPhoneController = TextEditingController();
  TextEditingController vetWhatsappController = TextEditingController();
  TextEditingController vetDetayController = TextEditingController();
  TextEditingController vetAdresController = TextEditingController();

  



  File? gorselPath;

  XFile? fileYeni;

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
  bool _petTaksiSwitch = false;
  bool _yediyirmidortSwitch = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double genislik = MediaQuery.of(context).size.width;
    double yukseklik = MediaQuery.of(context).size.height;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          // Navigating to the dashboard screen if the user is authenticated
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HosgeldinPage()));
        }
        if (state is AuthError) {
          // Showing the error message if the user has entered invalid credentials
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
        // TODO: implement listener
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Loading) {
            // Showing the loading indicator while the user is signing in
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UnAuthenticated) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue.shade300,
                title: Text('Veteriner Kayıt Formu'),
              ),
              body: formWidget(),
            );
          }
          return Container();
        },
      ),
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
            Center(
              child: Container(
                child: Text('Görsel'),
              ),
            ),
            textFieldOlustur(
                'Veteriner Klinik Adı',
                false,
                EdgeInsets.only(top: 25, right: 25, left: 25),
                TextInputType.name,
                vetNameController),
            textFieldOlustur(
                'Mail Adresi',
                false,
                EdgeInsets.only(top: 10, right: 25, left: 25),
                TextInputType.emailAddress,
                emailController),
            textFieldOlustur(
                'Şifre',
                true,
                EdgeInsets.only(
                  top: 10,
                  left: 25,
                  right: 25,
                ),
                TextInputType.text,
                passwordController),
            textFieldOlustur(
                'Telefon Numarası',
                false,
                EdgeInsets.only(top: 10, right: 25, left: 25),
                TextInputType.number,
                vetPhoneController),
            textFieldOlustur(
                'WhatsApp Hattı',
                false,
                EdgeInsets.only(top: 10, right: 25, left: 25),
                TextInputType.number,
                vetWhatsappController),
            Padding(
              padding: EdgeInsets.only(top: 10, right: 25, left: 25),
              child: TextFormField(
                  controller: vetDetayController,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 15),
                  child: Text('Pet Taksi Hizmeti veriyor musunuz?'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 15),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 15),
                  child: Text('7/24 hizmet veriyor musunuz?'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80, top: 15),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 15),
                  child: Text('Evde Bakım hizmeti veriyor musunuz?'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 15),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: _ilceSecilmisMi ? Colors.blue.shade300 : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
                ),
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
              padding:
                  EdgeInsets.only(top: 10, right: 25, left: 25, bottom: 10),
              child: TextFormField(
                  controller: vetAdresController,
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
            Center(
              child: Container(
                height: 60.h,
                width: 300.w,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _createAccountWithEmailAndPassword(context);
                    });
                  },
                  child: Text(
                    'Kayıt Ol',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Center imageUploadButton() {
    return Center(
      child: InkWell(
        splashColor: Colors.grey,
        onTap: () {
          _savePicture();
        },
        child: gorselPath == null
            ? Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('lib/assets/button.png'))),
              )
            : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.file(gorselPath!)),
      ),
    );
  }

  void _savePicture() async {
    final ImagePicker _picker = ImagePicker();
    XFile? _file = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      fileYeni = _file;
      File photo = File(fileYeni!.path);
      gorselPath = photo;
    });
  }

  Padding textFieldOlustur(String text, bool sifreMi, EdgeInsets padding,
      TextInputType tip, TextEditingController controller) {
    return Padding(
      padding: padding,
      child: TextFormField(
          controller: controller,
          obscureText: sifreMi,
          keyboardType: tip,
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

  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(
            emailController.text,
            passwordController.text,
            vetNameController.text,
            vetPhoneController.text,
            vetWhatsappController.text,
            vetDetayController.text,
            _petTaksiSwitch,
            _yediyirmidortSwitch,
            _evdeBakimSwitch,
            _secilenIl!,
            _secilenIlce!,
            vetAdresController.text,
            fileYeni!),
      );
    }
  }
}
