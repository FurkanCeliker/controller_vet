import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class VetModel extends Equatable {
  final String? userId;
  final bool? yediYirmiDort;
  final bool? evdeBakim;
  final bool? petTaksi;
  final String? vetAdi;
  final String? vetAdres;
  final String? vetIl;
  final String? vetIlce;
  final int? vetPhone;
  final int? vetWhatsapp;
  final String? vetDescription;
  final String? vetPhoto;
  final String? vetEmail;
  final XFile? file;
  
  VetModel({ this.vetEmail, this.userId, this.yediYirmiDort, this.evdeBakim, this.petTaksi, this.vetAdi, this.vetAdres, this.vetIl, this.vetIlce, this.vetPhone, this.vetWhatsapp, this.vetDescription, this.vetPhoto,this.file});

  static var empty =VetModel(userId: '');

  bool get isEmpty=> this== VetModel.empty;
  bool get isNotEmpty=> this != VetModel.empty;

  @override
  // TODO: implement props
  List<Object?> get props => [userId,vetEmail,vetAdi,vetPhoto,vetWhatsapp,vetAdres,vetIl,vetPhone];

 static Map<String,dynamic> toMap(QueryDocumentSnapshot snap){
    Map<String,dynamic> map = {
      'id': snap['vet_id'],
      'adi': snap['vet_adi'],
      'il': snap['vet_il'],
      'ilce':snap['vet_ilce'],
      'whatsapp':snap['vet_wp'],
      'telefon':snap['vet_tel'],
      'photo':snap['vet_resim'],
      'email':snap['vet_mail'],
      'adres':snap['vet_adres'],
      'description': snap['vet_detay'],
      
    };
    return map;
  }

  static List fromList(QueryDocumentSnapshot snap){
    List vetM = [snap];
    return vetM;
  }

  static VetModel fromSnapshot(QueryDocumentSnapshot snap){
    VetModel vetModel =VetModel(
      vetAdi: snap['vet_adi'],
      vetIl: snap['vet_il'],
      vetIlce: snap['vet_ilce'],
      vetAdres: snap['vet_adres'],
      vetWhatsapp: snap['vet_wp'],
      vetDescription: snap['vet_detay'],
      vetEmail: snap['vet_mail'],
      vetPhone: snap['vet_tel'],
      vetPhoto: snap['vet_resim']
    );


    return vetModel;
  }
  
}