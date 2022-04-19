
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controller_vet/constant/constants.dart';
import 'package:controller_vet/pages/vet_detail.dart';
import 'package:flutter/material.dart';

class ListviewVet extends StatefulWidget {
  String il;
  String ilce;
  bool petTaksi;
  bool evdeBakim;
  bool yediYirmiDort;
  ListviewVet(
      {Key? key,
      required this.il,
      required this.ilce,
      required this.evdeBakim,
      required this.petTaksi,
      required this.yediYirmiDort})
      : super(key: key);

  @override
  State<ListviewVet> createState() => _ListviewVetState();
}

class _ListviewVetState extends State<ListviewVet> {
  @override
  void initState() {
    
    super.initState();
    getVetData(widget.il, widget.ilce, widget.petTaksi, widget.evdeBakim,
        widget.yediYirmiDort);
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    double _yukseklik = Constants.getSizeHeight(context);
    double _genislik = Constants.getSizeWidth(context);
    return Material(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Padding(
              padding:const EdgeInsets.only(),
              child: Container(
                width: _genislik,
                height: _yukseklik * 0.15,
                decoration:const BoxDecoration(
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
              top: _yukseklik * 0.04,
              left: _yukseklik * 0.04,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon:const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: _yukseklik * 0.05,
              left: _genislik * 0.32,
              child: const Text(
                'Arama Sonuçları',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.only(
                  top: _yukseklik * 0.16, right: _genislik * 0.02),
              child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  future: getVetData(widget.il, widget.ilce, widget.petTaksi,
                      widget.evdeBakim, widget.yediYirmiDort),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!.docs;

                      return ListView.builder(
                        itemExtent: 125.0,
                        cacheExtent: 100,
                        //   padding: EdgeInsets.all(10.0),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              //GİDİLECEK
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => VetDetail(
                                        vet: data[index],
                                      )));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: _genislik * 0.023),
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
                                        borderRadius:const BorderRadius.all(
                                            Radius.circular(16.0)),
                                        child: Hero(
                                          tag: data[index]['vet_resim'],
                                          child: Image.network(
                                            data[index]['vet_resim'] ?? '',
                                            width: _genislik * 0.21,
                                            height: _yukseklik * 0.09,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      title: Text(data[index]['vet_adi'] ?? ''),
                                      subtitle:
                                          Text(data[index]['vet_adres'] ?? '')),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                     const Center(
                        child: Text('Bir hata meydana geldi'),
                      );
                    }
                    return  Container();
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getVetData(String il, String ilce,
      bool petTaksi, bool evdeBakim, bool yediYirmiDort) async {
    var _result = await _firestore
        .collection('vet')
        .where('vet_il', isEqualTo: il)
        .where('vet_ilce', isEqualTo: ilce)
        .where('vet_724', isEqualTo: yediYirmiDort)
        .where('vet_pettaksi', isEqualTo: petTaksi)
        .where('vet_evdebakim', isEqualTo: evdeBakim)
        .get();

    return _result;
  }
}
