import '../model/user_model.dart';

abstract class AuthBase{
Future<Users> currentUser();
Future<bool> SignOut();
 
}