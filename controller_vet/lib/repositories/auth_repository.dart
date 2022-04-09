
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Kullanıcı bulunamadı');
      } else if (e.code == 'wrong-password') {
        throw Exception('Parola yanlış');
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      Exception(e);
    }
  }

  Future<void> signInWithFacebook() async{
    try{
      
    }catch(e){

    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
          await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Exception(e.toString());
    }
  }

  Future<void> savePicture(XFile file) async{
    
  }


  Future<void> signUp({required String email, required String password,required String vetName,required String vetPhone,required String vetWhatsapp,required String vetDescription,required bool petTaksi, required bool yediYirmiDort,required bool evdeBakim, required String petIl, required String petIlce, required String petAdres, required XFile file}) async {
    try {
      

      FirebaseFirestore _firestore= FirebaseFirestore.instance;
     var result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
          var user= result.user;

         await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({'user_id':user.uid,'user_password':password});
        
        
         await _firestore.collection("vet").doc(user.uid).set({'vet_724':yediYirmiDort,'vet_adi':vetName,'vet_adres':petAdres,'vet_detay':vetDescription,'vet_evdebakim':evdeBakim,'vet_il':petIl,'vet_ilce':petIlce,'vet_mail':email,'vet_pettaksi':petTaksi,'vet_sifre':password,'vet_tel':vetPhone,'vet_wp':vetWhatsapp,'vet_id':user.uid});

         var _profileRef=FirebaseStorage.instance.ref('vet/${user.uid}');
         var _task=_profileRef.putFile(File(file.path));
         _task.whenComplete(() async{
           var _url = await _profileRef.getDownloadURL();
           _firestore.doc('vet/${user.uid}').set({'vet_resim':_url},SetOptions(merge: true));
         });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
}
}
