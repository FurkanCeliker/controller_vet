import 'package:controller_vet/pages/vet_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListviewVet extends StatefulWidget {
  ListviewVet({Key? key}) : super(key: key);

  @override
  State<ListviewVet> createState() => _ListviewVetState();
}

class _ListviewVetState extends State<ListviewVet> {
  final int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          
                          blurRadius: 5,
                          color: Colors.grey,
                          blurStyle: BlurStyle.normal,
                          spreadRadius: 3),
                    ],
                    color: Color(0xFF6C60E1),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
              ),
            ),
            Positioned(
              top: 0.04.sh,
              left: 0.03.sh,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 0.05.sh,
              left: 0.15.sh,
              child: Container(
                  child: Text(
                'Arama Sonuçları',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 120),
              child: ListView.builder(
                itemExtent: 100.0,
                //   padding: EdgeInsets.all(10.0),
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      //GİDİLECEK
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => VetDetail()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                                color: Colors.grey.withOpacity(0.1))),
                        shadowColor: Colors.blue.shade200,
                        child: Center(
                          child: ListTile(
                              leading: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                child: Image.asset(
                                  "lib/assets/flamingo.jpg",
                                  width: 80.w,
                                  height: 100.h,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              title: Text("Flamingo Veteriner"),
                              subtitle:
                                  Text("Anadolu caddesi beste sokak no 9")),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
