import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ComplaintsAndSuggestions extends StatefulWidget {
  @override
  _ComplaintsAndSuggestionsState createState() => _ComplaintsAndSuggestionsState();
}

class _ComplaintsAndSuggestionsState extends State<ComplaintsAndSuggestions> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController kindController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('الشكاوى والإقتراحات',style: TextStyle(
            fontSize: 22,
            fontFamily: 'AmiriQuran',
            color: Colors.white,
            height: 1.5)),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 12)),
            Padding(
              padding: EdgeInsets.only(right: 10,left: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child: Text('أرسل لنا ملاحظاتك او شكاويك وبإذن الله سنستجيب لك بأسرع وقت ممكن .',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'AmiriQuran',
                            color: Colors.black,
                            height: 1.5)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:50,right: 20,left: 20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: nameController,
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'ضع أسمك هنا'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Fill name Input';
                      }
                      // return 'Valid Name';
                    },
                  ),
                  SizedBox(height: 10,),

                  TextFormField(
                    controller: mobileController,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'رقم الموبايل'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Fill name Input';
                      }
                      // return 'Valid Name';
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: kindController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                        hintText: '... إقتراح , شكوى , مشكلة تقنية , تبليغ , أو غير ذلك'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Fill name Input';
                      }
                      // return 'Valid Name';
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: messageController,
                    textAlign: TextAlign.right,
                    maxLength: 500,
                    maxLines: 10,
                    decoration: InputDecoration(
                        hintText: 'الرسالة'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Fill name Input';
                      }
                      // return 'Valid Name';
                    },
                  ),
                  SizedBox(height: 40,),
                  InkWell(
                    onTap: ()async{
                      var currentUser = await FirebaseAuth.instance.currentUser();
                      if(_formkey.currentState.validate()){
                        Firestore.instance.collection('Complaints and Suggestions').add({
                          'name':nameController.text,
                          'mobile': mobileController.text,
                          'kind': kindController.text,
                          'message': messageController.text,
                          'emailUser':currentUser.email,
                          'time': DateFormat('yyyy-MM-dd-HH:mm').format(DateTime.now()),
                          'uid':currentUser.uid
                        });
                      }
                      nameController.clear();
                      messageController.clear();
                      kindController.clear();
                      mobileController.clear();

                    },
                    child: Center(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue[800]
                        ),
                        child: Center(
                          child: Text('أرسل',style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'AmiriQuran',
                              color: Colors.white,
                              height: 1)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10,left: 10,top: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300]
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                    child: Text('.ملاحظة : كل ما تكتبه هنا هو سري ولا أحد يطلع عليه غير إدارة التطبيق',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'AmiriQuran',
                            color: Colors.black,
                            height: 1.5)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
