import 'dart:ui';
import 'package:controller_vet/constant/constants.dart';
import 'package:controller_vet/pages/sorgu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HosgeldinPage extends StatelessWidget {
  const HosgeldinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _yukseklik=Constants.getSizeHeight(context);
    double _genislik= Constants.getSizeWidth(context);
    return Scaffold(
      body: Stack(
        children: [
          BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child:Container(
            width: _genislik,
            height: _yukseklik,
            color:const Color(0xff6892FE),
          ),
        ),
         Positioned(
          left: 0.1.sh,
          top: 0.0.sh,
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(
        color:const Color.fromARGB(255, 123, 128, 115).withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset:const Offset(0, 3), // changes position of shadow
      ),],
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 60, 230, 102),
            ),
            height: _yukseklik*0.6,
            width: _genislik*1,
          ),
        ),

        Positioned(
          bottom: _yukseklik*0.01,
          top: _yukseklik*0.3,
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(
        color: Colors.yellow.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset:const Offset(0, 3), // changes position of shadow
      ),],
                shape: BoxShape.circle,
                color: Colors.deepOrange
            ),
            height: _yukseklik*0.2,
            width: _genislik*1.3,
          ),
        ),
          
          Positioned(
            top: _yukseklik*0.16,
            left: _genislik*0.25,
            child: Container(
              width: _genislik*0.5,
              height: _yukseklik*0.25,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset:const Offset(0, 3), // changes position of shadow
      ),
                ],
                color: Colors.white,
                image:const DecorationImage(
                  image: AssetImage(
                    'lib/assets/hosgeldin.jpg',
                  ),
                ),
                borderRadius: BorderRadius.circular(150),
              ),
            ),
          ),

          
         
          Positioned(
            
             
              child: Center(
                child:   Text(
                    "VetBul'a Hoşgeldin",
                    style: TextStyle(fontSize: 45, color: Colors.white),
                  ),
              ),
              ),
          Positioned(
              bottom: _yukseklik*0.3,
              left: _genislik*0.25,
              child: SizedBox(
                width: 200.w,
                height: 50.h,
                child: ElevatedButton(
                  
                  style: ElevatedButton.styleFrom(primary:const Color.fromARGB(255, 95, 230, 99),),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> IlIlceSecimi()));
                  }, child:const Text('Geç',style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
              )),
              
               Positioned(
                 bottom: 0.05.sh,
                 left: 0.2.sh,
                 child: Container(
                  
                  decoration:const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('lib/assets/vet.png'),
                        fit: BoxFit.cover),
                  ),
                             ),
               ),
            
              
        ],
      ),
    );
  }
}
