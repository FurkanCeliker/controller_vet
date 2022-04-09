import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class Users extends Equatable {
  final String userId;
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
  
  Users({this.vetEmail, required this.userId, this.yediYirmiDort, this.evdeBakim, this.petTaksi, this.vetAdi, this.vetAdres, this.vetIl, this.vetIlce, this.vetPhone, this.vetWhatsapp, this.vetDescription, this.vetPhoto,this.file});

  static var empty =Users(userId: '');

  bool get isEmpty=> this== Users.empty;
  bool get isNotEmpty=> this != Users.empty;

  @override
  // TODO: implement props
  List<Object?> get props => [userId,vetEmail,vetAdi,vetPhoto];
  
}