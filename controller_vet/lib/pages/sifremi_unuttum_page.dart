import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SifremiUnuttumPage extends StatefulWidget {
  SifremiUnuttumPage({Key? key}) : super(key: key);

  @override
  State<SifremiUnuttumPage> createState() => _SifremiUnuttumPageState();
}

class _SifremiUnuttumPageState extends State<SifremiUnuttumPage> {

  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _mailController = TextEditingController();

  @override
  void dispose() {
    _mailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Şifremi Unuttum'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('MAİL ADRESİNİZİ GİRİN'),
              ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) {
                  email !=null && EmailValidator.validate(email) ? 'Mail adresi hatalı': null;
                },
                controller: _mailController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12)),
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: 'Mail Adresi',
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ))),
              ),
            ),
      
            ElevatedButton(onPressed: () async{
             _resetPassword();
            }, child: Text('Şifre Yenile'))
          ],
        ),
      ),
    );
  }

  Future _resetPassword() async{
    showDialog(
      barrierDismissible: false,
      context: context,
     builder: (context){
       return Center(child: CircularProgressIndicator(),);
    });
    try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email:_mailController.text.trim());
    const snackBar = SnackBar(
  content: Text('Mail Gönderildi'),
);

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Navigator.of(context).popUntil((route) => route.isFirst);
    }on FirebaseAuthException catch(e){
      debugPrint(e.message);
      Navigator.of(context).pop();

   
    }
  }
}
