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
import 'package:url_launcher/url_launcher.dart';

import 'ShowAds.dart';

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
      showBody = false;
    });
    Timer(Duration(seconds: 2), () {
      setState(() {
        if (currentUserUid != null) {
          showBody = true;
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
                                padding: EdgeInsets.only(top:screenSizeHieght<895?443: 420),
                                child: ListView.builder(
                                    itemCount: snapshot.data.documents.length,
                                    itemBuilder:
                                        (BuildContext context, index) {
                                      return Card(
                                        elevation: 5,
                                        child: SizedBox(
                                          height: 58,
                                          child: ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  BouncyPageRoute(
                                                      widget: ShowAd(
                                                        documentId: snapshot
                                                            .data
                                                            .documents[index]
                                                            .documentID,
                                                      )));
                                            },
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
                                    })),
                          ],
                        );
                    }
                  },
                )),
            bottomNavigationBar: CurvedNavigationBar(
                color: Color(0xfff26726),
                backgroundColor: Colors.orange,
                buttonBackgroundColor: Colors.white,
                animationDuration: Duration(milliseconds: 300),
                height: 50,
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
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top:screenSizeHieght>750 ?110:300)),
              Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Loading...',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 37,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.blue,
                    size: 55,
                  ))
            ],
          ),
          Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 40)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          onTap: () async {
                            await FirebaseAuth.instance.signOut().then((value) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                    return LoginScreen(
                                      autoLogin: false,
                                    );
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
              alignment: Alignment(0.9,screenSizeHieght>750? 0:0.4),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical:screenSizeHieght>750? 170:70, horizontal: 1),
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
                              radius: 27,
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
                        SizedBox(
                          height: 3,
                        ),
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
                      height: 9,
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
                      height: 2,
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
                      height: 2,
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
                      onTap: () {
                        Navigator.push(
                            context, BouncyPageRoute(widget: Contact()));
                      },
                      child: Padding(
                        padding:
                        EdgeInsets.only(top: 5, bottom: 5, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.arrow_back_ios),
                            SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            Text('اتصل بنا',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 17,
                                    fontFamily: 'AmiriQuran',
                                    height: 1,
                                    color: Colors.grey[700])),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.grey[400]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 3),
                                child: Center(
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.blueAccent,
                                  ),
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
                      onTap: () {
                        Navigator.push(
                            context, BouncyPageRoute(widget: AboutUs()));
                      },
                      child: Padding(
                        padding:
                        EdgeInsets.only(top: 5, bottom: 5, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.arrow_back_ios),
                            SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Text('حول التطبيق',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 17,
                                    fontFamily: 'AmiriQuran',
                                    height: 1,
                                    color: Colors.grey[700])),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.grey[400]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 3),
                                child: Center(
                                  child: Icon(
                                    Icons.info,
                                    color: Colors.blueAccent,
                                  ),
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
                      onTap: () {
                        Navigator.push(
                            context,
                            BouncyPageRoute(
                                widget: ComplaintsAndSuggestions()));
                      },
                      child: Padding(
                        padding:
                        EdgeInsets.only(top: 5, bottom: 5, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.arrow_back_ios),
                            SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Text('الشكاوى والإقتراحات',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 17,
                                    fontFamily: 'AmiriQuran',
                                    height: 1,
                                    color: Colors.grey[700])),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.grey[400]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 3),
                                child: Center(
                                  child: Icon(
                                    Icons.markunread_mailbox,
                                    color: Colors.yellow,
                                  ),
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
                      onTap: () {
                        chosePage(context);
                      },
                      child: Padding(
                        padding:
                        EdgeInsets.only(top: 5, bottom: 5, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.arrow_back_ios),
                            SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text('  سياسة الخصوصية وشروط الاستخدام',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 17,
                                    fontFamily: 'AmiriQuran',
                                    height: 1,
                                    color: Colors.grey[700])),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.grey[400]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 3),
                                child: Center(
                                  child: Icon(
                                    Icons.security,
                                    color: Colors.yellow,
                                  ),
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
                      onTap: () {
                        loginAdmin(context);
                      },
                      child: Padding(
                        padding:
                        EdgeInsets.only(top: 5, bottom: 5, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.arrow_back_ios),
                            SizedBox(
                              width: 60,
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            Text('آدمن',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 17,
                                    fontFamily: 'AmiriQuran',
                                    height: 1,
                                    color: Colors.grey[700])),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.grey[400]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 3),
                                child: Center(
                                  child: Icon(
                                    Icons.verified_user,
                                    color: Colors.red,
                                  ),
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

  Future<Null> loginAdmin(BuildContext context) async {
    TextEditingController adminNameController = TextEditingController();
    TextEditingController adminPasswordController = TextEditingController();
    TextEditingController adminNoController = TextEditingController();
    int adminNo;
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
                    onChanged: (val) {
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
                  if (adminName[adminNo] == adminNameController.text &&
                      adminPassword[adminNo] == adminPasswordController.text) {
                    Navigator.of(context).pop();
                    Navigator.push(context, BouncyPageRoute(widget: Admin()));
                  } else {}
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

Future<Null> chosePage(BuildContext context) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            ': اختر ماتريد رؤيته ',
            textAlign: TextAlign.right,
            style:
            TextStyle(fontSize: 17, fontFamily: 'AmiriQuran', height: 1.5),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    String urlPrivacyPolicy =
                        'https://sites.google.com/view/privacy-policy-for-sooq/%D8%A7%D9%84%D8%B5%D9%81%D8%AD%D8%A9-%D8%A7%D9%84%D8%B1%D8%A6%D9%8A%D8%B3%D9%8A%D8%A9';
                    launch(urlPrivacyPolicy);
                  },
                  child: Text(
                    'اذهب الى سياسة الخصوصية',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'AmiriQuran',
                        color: Colors.white,
                        height: 1.5),
                  ),
                  color: Colors.blueAccent,
                ),
                FlatButton(
                  onPressed: () {
                    String url =
                        'https://sites.google.com/view/privacy-policy-sooqalfurat/%D8%A7%D9%84%D8%B5%D9%81%D8%AD%D8%A9-%D8%A7%D9%84%D8%B1%D8%A6%D9%8A%D8%B3%D9%8A%D8%A9';
                    launch(url);
                  },
                  child: Text(
                    'اذهب الى سياسة الخصوصية بالانجليزية',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'AmiriQuran',
                        color: Colors.white,
                        height: 1.5),
                  ),
                  color: Colors.blueAccent,
                ),
                FlatButton(
                  onPressed: () {
                    String urlPrivacyPolicy =
                        'https://sites.google.com/view/terms-of-use-sooq/%D8%A7%D9%84%D8%B5%D9%81%D8%AD%D8%A9-%D8%A7%D9%84%D8%B1%D8%A6%D9%8A%D8%B3%D9%8A%D8%A9';
                    launch(urlPrivacyPolicy);
                  },
                  child: Text(
                    'اذهب الى شروط الاستخدام',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'AmiriQuran',
                        color: Colors.white,
                        height: 1.5),
                  ),
                  color: Colors.blueAccent,
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
          ],
        );
      });
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
        title: Text(
          'تواصل معنا',
          style: TextStyle(
              fontSize: 27,
              fontFamily: 'AmiriQuran',
              color: Colors.white,
              height: 1),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 70)),
            Padding(
              padding: EdgeInsets.only(right: 5, left: 5),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white),
                  child: InkWell(
                    onTap: () {
                      launch('mailto:App@souqalfurat.com');
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'App@souqalfurat.com',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'AmiriQuran',
                            color: Colors.blue[900],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 40),
                            child: Icon(
                              Icons.email,
                              color: Colors.blue,
                              size: 40,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5, left: 5),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white),
                  child: InkWell(
                    onTap: () {
                      launch('mailto:khaled_salehalali@hotmail.com');
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'khaled_salehalali@hotmail.com',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'AmiriQuran',
                            color: Colors.blue[900],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 40),
                            child: Icon(
                              Icons.email,
                              color: Colors.blue,
                              size: 40,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5, left: 5),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white),
                  child: InkWell(
                    onTap: () {
                      launch('tel:0096598824567');
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          ' 0096598824567 ',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'AmiriQuran',
                              color: Colors.blue[900],
                              height: 1.5),
                        ),
                        Text(
                          ':واتساب ',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'AmiriQuran',
                              color: Colors.blue[900],
                              height: 1.5),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 40),
                            child: Icon(
                              Icons.phone_iphone,
                              color: Colors.blue,
                              size: 40,
                            ))
                      ],
                    ),
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
      backgroundColor: Color(0xff4d4d4d),
      appBar: AppBar(
        title: Text(
          'حول التطبيق',
          style: TextStyle(
              fontSize: 27,
              fontFamily: 'AmiriQuran',
              color: Colors.white,
              height: 1),
        ),
      ),
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.only(top: 16)),

          Card(
            color: Color(0xff4d4d4d),
            child: Padding(
              padding: EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 7),
              child: Text('حول التطبيق',textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'AmiriQuran',
                    color: Colors.white,
                    height: 1),),
            ),
          ),
          Card(
            color: Color(0xff4d4d4d),
            child: Padding(
              padding: EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 7),
              child: Text('ان تطبيق سوق الفرات هو منصة تمكن مستخدميه من الإعلان عن اي شئ \nاو عن اي سلعة يريدون بيعها, كما يمكن التطبيق اي شخص من الإعلان عن خدمات او اعمال يقوم بتقديمها. ',textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'AmiriQuran',
                    color: Colors.white,
                    height: 1.5),),
            ),
          ),
          Card(
            color: Color(0xff4d4d4d),
            child: Padding(
              padding: EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 7),
              child: Text('وبالمقابل يمكن التطبيق مستخدميه من البحث عن متطلباتهم من سلع واغراض \nوخدمات بكل يسر وامان حتى يستطيع المستخدم التواصل مع اصحاب تلك السلع والخدمات بشكل مباشر دون وجود وسيط',textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'AmiriQuran',
                    color: Colors.white,
                    height: 1.5),),
            ),
          ),

          Card(
            color: Color(0xff4d4d4d),
            child: Padding(
              padding: EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 7),
              child: Text(': يحوي التطبيق على الاقسام التالية \nالسيارات والدراجات , الموبايل , أجهزة - إلكترونيات , وظائف وأعمال\n  المنزل , مهن وخدمات , المواشي ,  المعدات والشاحنات , ألعاب , الزراعة , الأطعمة , الألبسة.',textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'AmiriQuran',
                    color: Colors.white,
                    height: 1.5),),
            ),
          ),
          Card(
            color: Color(0xff4d4d4d),
            child: Padding(
              padding: EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 7),
              child: Text(': دليل الإستخدام \nلإستخدام تطبيق سوق الفرات اول مره قم بتسجيل حساب خاص بك \nبشكل اعتيادي بواسطة البريد الإلكتروني, بعدها يمكنك تصفح\n الإعلانات الموجودة في كل الأقسام مباشرة ويمكنك التواصل مع المعلنين\n واضافة تعليق على إعلاناتهم .كما يمكنك اظافة اعلانك بشكل مجاني حتى\n يتمكن الناس من رؤيته , وذلك بالانتقال الى واجهة اظافة اعلان جديد التي\n تمكنك من اظافة كل المعلومات التي تحتاج لعرضها في اعلانك  مثل الصور \nواسم الاعلان ووصف المعروض والسعر والمنطقة ورقم الهاتف للتواصل والقسم الخاص باعلانك ',textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'AmiriQuran',
                    color: Colors.white,
                    height: 1.5),),
            ),
          ),
          Card(
            color: Color(0xff4d4d4d),
            child: Padding(
              padding: EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 7),
              child: Text(': رؤية \nيهدف تطبيق سوق الفرات الى جعل اي شخص قادر على بيع مايريد من السلع \nوالحاجات وتقديم الخدمات والاعمال بشكل سهل وميسر للوصول الى كل \nالناس .من اهداف انشاء هذا التطبيق هو مساعدة مقدمي الخدمات واصحاب\n المهن والاعمال والحرف للوصول الى نطاق واسع من طالبي تلك الخدمات ,\n كما يهدف التطبيق الى توسيع افق الخدمات والاعمال وفتح سبل للتجارة\n المباشرة بين البائع والشاري  ',textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'AmiriQuran',
                    color: Colors.white,
                    height: 1.5),),
            ),
          ),

        ],
      ),
    );
  }
}
