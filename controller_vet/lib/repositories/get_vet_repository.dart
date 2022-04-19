import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class GetVetRepository{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<QuerySnapshot<Map<String, dynamic>>> getVetData({required String vetIl, required String vetIlce, required bool vetPetTaksi,required bool vetYediYirmiDort, required bool vetEvdeBakim})async {
   var _vetRef = _firestore.collection('vet');
var _result =  _vetRef.where('vet_il', isEqualTo: vetIl)
        .where('vet_ilce', isEqualTo: vetIlce)
        .where('vet_724', isEqualTo: vetYediYirmiDort)
        .where('vet_pettaksi', isEqualTo: vetPetTaksi)
        .where('vet_evdebakim', isEqualTo: vetEvdeBakim).get();
       return _result;
        
  }
}