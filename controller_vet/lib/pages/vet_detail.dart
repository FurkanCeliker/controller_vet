import 'dart:ui';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VetDetail extends StatefulWidget {
  VetDetail({Key? key}) : super(key: key);

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
    return Scaffold(
      body:  Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 330),
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
                        image: ExactAssetImage('lib/assets/flamingo.jpg'),
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
                    icon: Icon(Icons.arrow_back_ios),
                    iconSize: 30,
                    color: Colors.white,
                  ),
                  Text(
                    'Veteriner Detay',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.whatsapp),
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Text(
                        'Flamingo Veteriner',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    
                   
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on),
                             SizedBox(width: 5),
                               Text(
                            'İstanbul',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                            ],
                          ),
                      
                    
                    
                    Padding(
                      padding: EdgeInsets.only(left: 30, top: 10, right: 30),
                      child: Divider(
                        height: 2.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Container(
                        width: 300.w,
                        height: 200.h,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                width: MediaQuery.of(context).size.width,
                height: 450.h,
              ),
            ),
            Positioned(
                top: 0.14.sh,
                left: 0.15.sh,
                right: 0.15.sh,
                child: Container(
                  width: 100.w,
                  height: 250.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    image: DecorationImage(
                      image: AssetImage('lib/assets/flamingo.jpg'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(),
              child: Align(
                
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 350,
                  height: 230,
                  child: ContainedTabBarView(
                    tabBarProperties: TabBarProperties(
                        indicatorColor: Colors.transparent,
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.black),
                    tabs: [
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
                                  padding: const EdgeInsets.only(top: 30,left: 15),
                                  child: Text(
                                    '2015 yılından bu yana Avcılar’da faaliyet göstermekte olan Lima Veteriner Kliniği, öncelikle “HAYVANA SAYGININ BAŞLADIĞI YER” olmayı kendine ilke edinmiştir. Çalışan kadrosu, modern ve teknolojik koşullarıyla bu felsefesini istisnasız korumayı başarmıştır…',
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
                                child: Column(children: [
                                  Text('Telefon :  0536 280 93 17'),
                                  SizedBox(height: 10,),
                                  Text('Mail : info@flamingo.com'),
                                ],),
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
                                  'Anadolu caddesi beste sokak no 9 daire 5',
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    onChange: (index) => print(index),
                  ),
                ),
              ),
            ),
          ],
        ),
      
    );
  }
}
