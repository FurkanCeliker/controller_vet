import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:controller_vet/constant/constants.dart';
import 'package:controller_vet/pages/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class VetDetail extends StatefulWidget {
  QueryDocumentSnapshot<Map<String, dynamic>> vet;
  VetDetail(
      {Key? key, required QueryDocumentSnapshot<Map<String, dynamic>> this.vet})
      : super(key: key);

  @override
  State<VetDetail> createState() => _VetDetailState();
}

class _VetDetailState extends State<VetDetail>
    with SingleTickerProviderStateMixin {
  TabController? _contollerTab;
  @override
  void initState() {
    _contollerTab = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _contollerTab?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _yukseklik = Constants.getSizeHeight(context);
    double _genislik = Constants.getSizeWidth(context);

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: _yukseklik * 0.45),
            child: Container(
              child: new BackdropFilter(
                // Bulanıklaştırma kısmı
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: new Container(
                  decoration:
                      new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.vet['vet_resim']),
                      fit: BoxFit.cover)),
            ),
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon:const Icon(Icons.arrow_back_ios),
                  iconSize: 30,
                  color: Colors.white,
                ),
                Text(
                  widget.vet['vet_adi'],
                  style:const TextStyle(color: Colors.white, fontSize: 18),
                ),
                IconButton(
                  onPressed: () {
                    launchWhatsapp(phone: widget.vet['vet_wp']);
                  },
                  icon:const Icon(Icons.whatsapp),
                  iconSize: 30,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0.sh,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: _yukseklik * 0.12),
                    child: Text(
                      widget.vet['vet_adi'],
                      style:const TextStyle(fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: _yukseklik*0.01),
                    child: Row(
                      
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       const Icon(Icons.location_on),
                      const  SizedBox(width: 5),
                        Text(
                          widget.vet['vet_il'],
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 30, top: _yukseklik * 0.03, right: 30),
                    child: Divider(
                      height: 3.h,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.only(top: 10),
                    child: Container(
                      width: 300.w,
                      height: 200.h,
                    ),
                  ),
                ],
              ),
              decoration:const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              width: MediaQuery.of(context).size.width,
              height: 450.h,
            ),
          ),
          Positioned(
              top: _yukseklik * 0.14,
              left: _genislik * 0.26,
              right: _genislik * 0.26,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ImageGet(url: widget.vet['vet_resim']),
                  ));
                },
                child: Hero(
                  tag: widget.vet['vet_resim'],
                  child: Container(
                    
                    height: _yukseklik*0.35,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      image: DecorationImage(
                        image: NetworkImage(widget.vet['vet_resim']),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.only(bottom: _yukseklik * 0.07),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                width: 350,
                height: 230,
                child: ContainedTabBarView(
                  tabBarProperties:const TabBarProperties(
                      indicatorColor: Colors.transparent,
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.black),
                  tabs:const [
                    Text(
                      'Detay',
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      'İletişim',
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      'Adres',
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                  views: [
                    SingleChildScrollView(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30, left: 15),
                              child: Text(
                                widget.vet['vet_detay'],
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Column(
                                children: [
                                  Text("Telefon: ${widget.vet['vet_tel']}"),
                                const  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Mail: ${widget.vet['vet_mail']}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Text(
                                widget.vet['vet_adres'],
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void launchWhatsapp({required String phone}) async {
    String url = "whatsapp://send?phone=+9$phone";
    launch(url);
  }
}
