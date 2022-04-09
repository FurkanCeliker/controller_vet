part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// When the user signing in with email and password this event is called and the [AuthRepository] is called to sign in the user
class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

// When the user signing up with email and password this event is called and the [AuthRepository] is called to sign up the user
class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String vetName;
  final String vetPhone;
  final String vetWhatsapp;
  final String vetDescription;
  final bool petTaksi;
  final bool yediYirmiDort;
  final bool evdeBakim;
  final String petIl;
  final String petIlce;
  final String petAdres;
  final XFile file;

  SignUpRequested(this.email, this.password, this.vetName, this.vetPhone, this.vetWhatsapp, this.vetDescription, this.petTaksi, this.yediYirmiDort, this.evdeBakim, this.petIl, this.petIlce, this.petAdres,this.file);
}

// When the user signing in with google this event is called and the [AuthRepository] is called to sign in the user
class GoogleSignInRequested extends AuthEvent {}

class FacebookSignInRequested extends AuthEvent{}
// When the user signing out this event is called and the [AuthRepository] is called to sign out the user
class SignOutRequested extends AuthEvent {}

class SavePicture extends AuthEvent{
  final XFile file;
  
  SavePicture(this.file);
 }
