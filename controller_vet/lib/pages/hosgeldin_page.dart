import 'dart:ui';

import 'package:controller_vet/pages/listview_vet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HosgeldinPage extends StatelessWidget {
  const HosgeldinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child:Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xff6892FE),
          ),
        ),
         Positioned(
          left: 0.1.sh,
          top: 0.0.sh,
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(
        color: Color.fromARGB(255, 123, 128, 115).withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),],
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 60, 230, 102),
            ),
            height: 400,
            width: 400,
          ),
        ),

        Positioned(
          bottom: 0.1.sh,
          top: 0.3.sh,
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(
        color: Colors.yellow.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),],
                shape: BoxShape.circle,
                color: Colors.deepOrange
            ),
            height: 300,
            width: 500,
          ),
        ),
          
          Positioned(
            top: 0.16.sh,
            left: 0.14.sh,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
                ],
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(
                    'lib/assets/hosgeldin.jpg',
                  ),
                ),
                borderRadius: BorderRadius.circular(150),
              ),
            ),
          ),

          
         
          Positioned(
              top: 0.55.sh,
              left: 0.010.sh,
              child: Text(
                "VetBul'a Hoşgeldin",
                style: TextStyle(fontSize: 45, color: Colors.white),
              )),
          Positioned(
              bottom: 0.2.sh,
              left: 0.11.sh,
              child: SizedBox(
                width: 200.w,
                height: 50.h,
                child: ElevatedButton(
                  
                  style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 95, 230, 99),),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ListviewVet()));
                  }, child: Text('Geç',style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
              )),
              
               Positioned(
                 bottom: 0.05.sh,
                 left: 0.2.sh,
                 child: Container(
                  
                  decoration: BoxDecoration(
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
