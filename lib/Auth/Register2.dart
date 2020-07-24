import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Login.dart';

class RegisterScreen2 extends StatefulWidget{
  @override
  _RegisterScreen2State createState() => _RegisterScreen2State();
}

class _RegisterScreen2State extends State<RegisterScreen2> {
  void initState()
  {
    super.initState();
  }


  final _formkey = GlobalKey<FormState>();

  TextEditingController _namecontroller = TextEditingController();

  TextEditingController _emailcontroller = TextEditingController();

  TextEditingController _passwordcontroller = TextEditingController();

  TextEditingController _countrycontroller = TextEditingController();


  @override
  void dispose()
  {
    _namecontroller.dispose();

    _emailcontroller.dispose();

    _passwordcontroller.dispose();

    _countrycontroller.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('تسجيل مستخدم جديد',style: TextStyle(
            fontSize: 24,
            fontFamily: 'AmiriQuran',
            height: 1),),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _namecontroller,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'الإسم',
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please Fill name Input';
                      }
                      // return 'Valid Name';
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailcontroller,
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
                    height: 20,
                  ),
                  TextFormField(
                    controller: _countrycontroller,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'المنطقة',
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please Fill Country Input';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 6,horizontal: 40),
                      child: Text('تسجيل',textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'AmiriQuran',
                            color: Colors.white,
                            height: 1),),
                    ),
                    onPressed: () async{
                      if(_formkey.currentState.validate()){
                        var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailcontroller.text, password: _passwordcontroller.text);
                        if(result != null)
                        {
                          Firestore.instance.collection('users').document(result.user.uid).setData({
                            'name':_namecontroller.text,
                            'area':_countrycontroller.text,
                            'user_uid':result.user.uid,
                            "time" :DateFormat('yyyy-MM-dd-HH:mm').format(DateTime.now()),
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        }else{
                          print('please try later');
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}