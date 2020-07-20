import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sooq1alzour/Auth/Login.dart';
import 'package:sooq1alzour/models/PageRoute.dart';
import 'package:sooq1alzour/Admin/Admin.dart';
import 'package:sooq1alzour/ui/ComplaintsAndSuggestions.dart';
import 'package:sooq1alzour/ui/EditAd.dart';
import 'AddNewAd.dart';
import 'Home.dart';

class MyAccount extends StatelessWidget {
  static const String id = "MyAccount";

  @override
  Widget build(BuildContext context) {
    return MyAccountF();
  }
}

DocumentSnapshot documentsUser;
bool deleteThisAd = false;
bool showData = false;
bool showBody = false;
DocumentSnapshot documentAdmin;
List adminName = [];
List adminPassword = [];
class MyAccountF extends StatefulWidget {
  @override
  _MyAccountFState createState() => _MyAccountFState();
}

class _MyAccountFState extends State<MyAccountF> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserInfo();
    setState(() {
      showBody=false;
    });
    Timer(Duration(seconds: 2), () {
      setState(() {
        if(currentUserUid!=null){
          showBody=true;
        }

      });
    });
  }

  var currentUserUid;
  getCurrentUserInfo() async {
    var currentUser = await FirebaseAuth.instance.currentUser();

    DocumentReference documentRef =
        Firestore.instance.collection('users').document(currentUser.uid);
    documentsUser = await documentRef.get();

    DocumentReference documentRefAdmin =
    Firestore.instance.collection('Admin').document('1');
    documentAdmin = await documentRefAdmin.get();
    adminName = documentAdmin['name'];
    adminPassword = documentAdmin['password'];
    setState(() {
      currentUserUid = currentUser.uid;
      showData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[

          showBody
              ? Scaffold(
                  backgroundColor: Colors.white,
                    body: Material(
                        child: StreamBuilder(
                      stream: Firestore.instance
                          .collection('Ads')
                          .where(
                            'uid',
                            isEqualTo: currentUserUid,
                          )
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData)
                          return Text(
                            'Loading...',
                            style: TextStyle(fontSize: 60),
                          );
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return new Text('Loading...');
                          default:
                            return Stack(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(top: 420),
                                    child: ListView.builder(
                                        itemCount: snapshot.data.documents.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          return Card(
                                            elevation: 5,
                                            child: SizedBox(
                                              height: 65,
                                              child: ListTile(
                                                title: Text(
                                                  snapshot.data.documents[index]
                                                      ['name'],
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                trailing: InkWell(
                                                    onTap: () {
                                                      print(currentUserUid);
                                                      Navigator.push(
                                                          context,
                                                          BouncyPageRoute(
                                                              widget: EditAd(
                                                            documentId: snapshot
                                                                .data
                                                                .documents[index]
                                                                .documentID,
                                                          )));
                                                    },
                                                    child: Icon(
                                                      Icons.mode_edit,
                                                      color: Colors.blue,
                                                      size: 32,
                                                    )),
                                                subtitle: Text(
                                                  snapshot.data.documents[index]
                                                      ['time'],
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                leading: InkWell(
                                                    onTap: () async {
                                                      await Alert(context);
                                                      deleteThisAd
                                                          ? Firestore.instance
                                                              .collection('Ads')
                                                              .document(snapshot
                                                                  .data
                                                                  .documents[
                                                                      index]
                                                                  .documentID)
                                                              .delete()
                                                              .then((value) {
                                                              print(
                                                                  'delete done');
                                                            })
                                                          : print('Do not');
                                                    },
                                                    child: Icon(
                                                      Icons.delete_forever,
                                                      color: Colors.red,
                                                    )),
                                              ),
                                            ),
                                          );
                                        })
                                ),

                              ],
                            );
                        }
                      },
                    )),
                  bottomNavigationBar: CurvedNavigationBar(
                      color: Colors.red[400],
                      backgroundColor: Colors.orange,
                      buttonBackgroundColor: Colors.white,
                      animationDuration: Duration(milliseconds: 300),
                      height: 60,
                      animationCurve: Curves.bounceInOut,
                      index: 0,
                      onTap: (index) {
                        Timer(Duration(milliseconds: 300), () {
                          if (index == 0) {
                            Navigator.of(context).pushNamed(MyAccount.id);
                          } else if (index == 1) {
                            Navigator.of(context).pushNamed(AddNewAd.id);
                          } else if (index == 2) {
                            Navigator.of(context).pushNamed(Home.id);
                          }
                        });
                      },
                      items: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.blue[900],
                          size: 29,
                        ),
                        Icon(
                          Icons.add_photo_alternate,
                          color: Colors.blue[900],
                          size: 31,
                        ),
                        Icon(
                          Icons.home,
                          color: Colors.blue[900],
                          size: 29,
                        ),
                      ]),
                )
              :  Container(
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'Loading...',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 40,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 40)),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          onTap: () async {
                            await FirebaseAuth.instance
                                .signOut()
                                .then((value) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) {
                                        return LoginScreen();
                                      }));
                            });
                          },
                          child: Icon(
                            Icons.exit_to_app,
                            size: 24,
                            color: Colors.deepOrange,
                          )),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        'تسجيل خروج',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'AmiriQuran',
                            height: 0.5),
                      ),
                    ],
                  ),
                  Text(
                    'حسابي',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'AmiriQuran',
                      height: 1,
                    ),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  SizedBox(
                    width: 30,
                  )
                ],
              ),
            ],
          ),
          Align(
              alignment: Alignment(0.9, 0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 1),
                child: Text(
                  'إعلاناتي',
                  style: TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      fontFamily: 'AmiriQuran',
                      height: 0.1,
                      color: Colors.blue[900]),
                ),
              )),

          Align(
            alignment: Alignment(0.9, 0),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 33, horizontal: 1),
              child: showData
                  ? Container(
                      child: Column(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 30,
                                    child: Icon(
                                      Icons.perm_identity,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  documentsUser.data.length > 0
                                      ? Text(
                                          documentsUser['name'],
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 18,
                                              fontFamily: 'AmiriQuran',
                                              height: 1.5,
                                              color: Colors.blue[900]),
                                        )
                                      : Container(),
                                  SizedBox(
                                    width: 6,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              documentsUser.data.length > 0
                                  ? Text(documentsUser['time'].toString(),
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 16,
                                          fontFamily: 'AmiriQuran',
                                          height: 1.4,
                                          color: Colors.grey[600]))
                                  : Container(),
                              SizedBox(
                                width: 3,
                              ),
                              Text(': عضو منذ ',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 16,
                                      fontFamily: 'AmiriQuran',
                                      height: 1.5,
                                      color: Colors.grey[600])),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              documentsUser.data.length > 0
                                  ? Text(documentsUser['area'].toString(),
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 16,
                                          fontFamily: 'AmiriQuran',
                                          height: 1.6,
                                          color: Colors.grey[600]))
                                  : Container(),
                              SizedBox(
                                width: 3,
                              ),
                              Text(': المنطقة ',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 16,
                                      fontFamily: 'AmiriQuran',
                                      height: 1.5,
                                      color: Colors.grey[600])),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              documentsUser.data.length > 0
                                  ? Text(currentUserUid.toString(),
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 15,
                                      fontFamily: 'AmiriQuran',
                                      height: 1.6,
                                      color: Colors.grey[600]))
                                  : Container(),
                              SizedBox(
                                width: 3,
                              ),
                              Text(': رقم العضوية ',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 16,
                                      fontFamily: 'AmiriQuran',
                                      height: 1.5,
                                      color: Colors.grey[600])),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 3,
                            color: Colors.grey,
                          ),

                              InkWell(
                                onTap: (){
                                  Navigator.push(context, BouncyPageRoute(widget: Contact()));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5,bottom: 5,right: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(Icons.arrow_back_ios),
                                      SizedBox(width: 50,),
                                      SizedBox(width: 50,),
                                      SizedBox(width: 50,),
                                      SizedBox(width: 50,),
                                      Text('اتصل بنا',textAlign: TextAlign.right,
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 17,
                                              fontFamily: 'AmiriQuran',
                                              height: 1,
                                              color: Colors.grey[700])),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: Colors.grey[400]
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                          child: Center(
                                            child:Icon(Icons.call,color: Colors.blueAccent,) ,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: Colors.grey,
                          ),

                          InkWell(
                            onTap: (){
                              Navigator.push(context, BouncyPageRoute(widget: AboutUs()));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 5,bottom: 5,right: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(Icons.arrow_back_ios),
                                  SizedBox(width: 50,),
                                  SizedBox(width: 50,),
                                  SizedBox(width: 50,),
                                  SizedBox(width: 50,),
                                  Text('حول التطبيق',textAlign: TextAlign.right,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 17,
                                          fontFamily: 'AmiriQuran',
                                          height: 1,
                                          color: Colors.grey[700])),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.grey[400]
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      child: Center(
                                        child:Icon(Icons.info,color: Colors.blueAccent,) ,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: Colors.grey,
                          ),
                          InkWell(
                            onTap: (){
                             Navigator.push(context, BouncyPageRoute(widget:ComplaintsAndSuggestions()));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 5,bottom: 5,right: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(Icons.arrow_back_ios),
                                  SizedBox(width: 50,),
                                  SizedBox(width: 50,),
                                  SizedBox(width: 50,),
                                  SizedBox(width: 50,),
                                  Text('الشكاوى والإقتراحات',textAlign: TextAlign.right,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 17,
                                          fontFamily: 'AmiriQuran',
                                          height: 1,
                                          color: Colors.grey[700])),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.grey[400]
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      child: Center(
                                        child:Icon(Icons.markunread_mailbox,color: Colors.yellow,) ,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: Colors.grey,
                          ),

                          InkWell(
                            onTap: (){
                              loginAdmin(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 5,bottom: 5,right: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(Icons.arrow_back_ios),
                                  SizedBox(width: 50,),
                                  SizedBox(width: 50,),
                                  SizedBox(width: 50,),
                                  SizedBox(width: 50,),
                                  Text('آدمن',textAlign: TextAlign.right,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 17,
                                          fontFamily: 'AmiriQuran',
                                          height: 1,
                                          color: Colors.grey[700])),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.grey[400]
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      child: Center(
                                        child:Icon(Icons.verified_user,color: Colors.red,) ,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: Colors.grey,
                          ),
                            ],
                          ),
                    )
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> Alert(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'حذف إعلان',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 22, fontFamily: 'AmiriQuran', height: 1.5),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'هل تريد حذف هذا الإعلان ؟',
                    style: TextStyle(
                        fontSize: 15, fontFamily: 'AmiriQuran', height: 1.4),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'لا',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'AmiriQuran',
                      color: Colors.white,
                      height: 1.5),
                ),
                color: Colors.blueAccent,
              ),
              SizedBox(
                width: 10,
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    deleteThisAd = true;
                  });

                  Navigator.of(context).pop();
                },
                child: Text(
                  'تأكيد',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'AmiriQuran',
                      color: Colors.white,
                      height: 1.5),
                ),
                color: Colors.blueAccent,
              ),
            ],
          );
        });
  }
  Future<Null> loginAdmin(BuildContext context)async {
    TextEditingController adminNameController = TextEditingController();
    TextEditingController adminPasswordController = TextEditingController();
    TextEditingController adminNoController = TextEditingController();
    int adminNo ;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'ان كنت آدمن , إملئ الحقول للدخول',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 17, fontFamily: 'AmiriQuran', height: 1.5),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[

                  TextFormField(
                    controller: adminNoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Admin Number',
                    ),
                    onChanged: (val){
                      adminNo = int.parse(val);
                    },
                  ),
                  TextFormField(
                    controller: adminNameController,
                    decoration: InputDecoration(
                      labelText: 'Admin Name',
                    ),
                  ),
                  TextFormField(
                    controller: adminPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'إلغاء',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'AmiriQuran',
                      color: Colors.white,
                      height: 1.5),
                ),
                color: Colors.blueAccent,
              ),
              SizedBox(
                width: 10,
              ),
              FlatButton(
                onPressed: () {
                 if(adminName[adminNo] == adminNameController.text &&
                     adminPassword[adminNo] == adminPasswordController.text){
                   Navigator.of(context).pop();
                   Navigator.push(context, BouncyPageRoute(widget:Admin()));

                 }else{

                 }
                },
                child: Text(
                  'دخول',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'AmiriQuran',
                      color: Colors.white,
                      height: 1.5),
                ),
                color: Colors.blueAccent,
              ),
            ],
          );
        });
  }
}

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تواصل معنا',style: TextStyle(
            fontSize: 27,
            fontFamily: 'AmiriQuran',
            color: Colors.white,
            height: 1),),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 70)),
            Padding(
              padding: EdgeInsets.only(right: 5,left: 5),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('khaled_salehalali@hotmail.com',style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'AmiriQuran',
                          color: Colors.blue[900],
                          ),),

                      Padding(
                        padding: EdgeInsets.only(left: 40),
                          child: Icon(Icons.email,color: Colors.blue,size: 40,))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5,left: 5),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(' 0096598824567 ',style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'AmiriQuran',
                          color: Colors.blue[900],
                          height: 1.5),),
                      Text(':واتساب ',style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'AmiriQuran',
                          color: Colors.blue[900],
                          height: 1.5),),
                      Padding(
                        padding: EdgeInsets.only(left: 40),
                          child: Icon(Icons.phone_iphone,color: Colors.blue,size: 40,))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حول التطبيق',style: TextStyle(
            fontSize: 27,
            fontFamily: 'AmiriQuran',
            color: Colors.white,
            height: 1),),
      ),
    );
  }
}

