import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sooq1alzour/Auth/Register2.dart';
import 'package:sooq1alzour/ui/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget{
  bool autoLogin;
  LoginScreen({this.autoLogin});
  @override
  _LoginScreenState createState() => _LoginScreenState(autoLogin: autoLogin);
}

class _LoginScreenState extends State<LoginScreen> {
  bool autoLogin  ;
  _LoginScreenState({this.autoLogin});

  void initState()
  {
    super.initState();
    if(autoLogin!=false){
      autoLoginF();
    }
  }
  autoLoginF()async{
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    setState(() {
      _passwordcontroller = TextEditingController(text: sharedPref.getString('password'));
      _emailcontroller = TextEditingController(text: sharedPref.getString('email'));
    });

    Timer(Duration(milliseconds: 100),(){
      login();
    });
  }
  saveShared()async{
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('email', _emailcontroller.text);
    sharedPref.setString('password', _passwordcontroller.text);
  }
  login()async{

    if(_formkey.currentState.validate()){
      saveShared();
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailcontroller.text, password: _passwordcontroller.text);
      if(result != null){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }else{
        print('user not found');
      }
    }
  }

  final _formkey = GlobalKey<FormState>();

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  @override
  void dispose()
  {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
            key: _formkey,
            child: ListView(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 30)),
                Center(child: Text('تسجيل الدخول',style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'AmiriQuran',
                  height: 1,
                ),),),
                Padding(padding: EdgeInsets.only(top: 220)),
                TextFormField(
                  controller: _emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'البريد الإلكتروني  (الإيميل)',
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please Fill Email Input';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordcontroller,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'كلمة المرور',
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please Fill Password Input';
                    }
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                RaisedButton(
                  color: Colors.blue,
                  child: Text('تسجيل الدخول',style: TextStyle(color: Colors.white,fontSize: 18,
                      fontFamily: 'AmiriQuran',
                      height: 1),),
                  onPressed: () async {
                    login();
                  },
                ),
                SizedBox(height: 50,),
                RaisedButton(
                  color: Colors.blue,
                  child: Text('تسجيل مستخدم جديد ',style: TextStyle(color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'AmiriQuran',
                      height: 1
                  ),
                  ),
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen2() ) );
                  },
                ),
              ],
            )
        ),
      ),
    );
  }



}