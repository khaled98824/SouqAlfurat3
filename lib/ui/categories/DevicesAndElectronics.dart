import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sooq1alzour/models/PageRoute.dart';
import '../AddNewAd.dart';
import '../AllAds.dart';
import '../Home.dart';
import '../SearchUi.dart';
import '../myAccount.dart';


class DevicesAndElectronics extends StatefulWidget {
  static const String id = "DevicesAndElectronics";

  @override
  _DevicesAndElectronicsState createState() => _DevicesAndElectronicsState();
}
String categoryName;
String department ;
class _DevicesAndElectronicsState extends State<DevicesAndElectronics> {
  var dropItemsDevicesAndElectronics = [
    'إختر القسم الفرعي',
    'لابتوب - كمبيوتر',
    'تلفزيون شاشات',
    "كاميرات - تصوير",
    "طابعات",
    "راوترات - أجهزة إنترنت",
    "أخرى"
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('أجهزة - إلكترونيات',textAlign: TextAlign.center,
                style: TextStyle(
        fontSize: 26,
        fontFamily: 'AmiriQuran',
        height: 1)),
          ),
          body:  Container(
            child: ListView(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 10)),
                Heade(),
                SearchArea(),
                Padding(padding: EdgeInsets.only(top: 160)),
                Container(
                  height:1,
                  width: MediaQuery.of(context).size.width - 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red[900]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom:12),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                         department = dropItemsDevicesAndElectronics[1];
                        categoryName='أجهزة - إلكترونيات';
                      });
                      Navigator.push(context, BouncyPageRoute(widget: Ads(department:department,category:categoryName)));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          size: 36,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 13),
                          child: Text(
                            'لابتوب - كمبيوتر',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'AmiriQuran',
                                height: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width - 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red[900]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        department = dropItemsDevicesAndElectronics[2];
                        categoryName='أجهزة - إلكترونيات';
                      });
                      Navigator.push(context, BouncyPageRoute(widget: Ads(department:department,category:categoryName)));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          size: 36,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Text(
                            'تلفزيون شاشات',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'AmiriQuran',
                                height: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height:1,
                  width: MediaQuery.of(context).size.width - 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red[900]),
                ),
                Padding(
                  padding: EdgeInsets.only(top:12, bottom:12),
                  child: InkWell(
                    onTap: () {
                      department = dropItemsDevicesAndElectronics[3];
                      categoryName='أجهزة - إلكترونيات';
                      Navigator.push(context, BouncyPageRoute(widget: Ads(department:department,category:categoryName)));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          size: 36,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text(
                            'كاميرات - تصوير',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'AmiriQuran',
                                height: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height:1,
                  width: MediaQuery.of(context).size.width - 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red[900]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom:12),
                  child: InkWell(
                    onTap: () {
                      department = dropItemsDevicesAndElectronics[4];
                      categoryName='أجهزة - إلكترونيات';
                      Navigator.push(context, BouncyPageRoute(widget: Ads(department:department,category:categoryName)));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          size: 36,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 17),
                          child: Text(
                            'طابعات',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'AmiriQuran',
                                height: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height:1,
                  width: MediaQuery.of(context).size.width - 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red[900]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom:12),
                  child: InkWell(
                    onTap: () {
                      department = dropItemsDevicesAndElectronics[5];
                      categoryName='أجهزة - إلكترونيات';
                      Navigator.push(context, BouncyPageRoute(widget: Ads(department:department,category:categoryName)));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          size: 36,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 30),
                          child: Text(
                            'راوترات - أجهزة إنترنت',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'AmiriQuran',
                                height: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height:1,
                  width: MediaQuery.of(context).size.width - 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red[900]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom:12),
                  child: InkWell(
                    onTap: () {
                      department = dropItemsDevicesAndElectronics[6];
                      categoryName='أجهزة - إلكترونيات';
                      Navigator.push(context, BouncyPageRoute(widget: Ads(department:department,category:categoryName)));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          size: 36,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 17),
                          child: Text(
                            'أخرى',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'AmiriQuran',
                                height: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height:1,
                  width: MediaQuery.of(context).size.width - 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red[900]),
                ),
              ],
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
              color: Colors.red[500],
              backgroundColor: Colors.orange,
              buttonBackgroundColor: Colors.white,
              animationDuration: Duration(milliseconds: 300),
              height: 63,
              animationCurve: Curves.bounceInOut,
              index: 1,
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
        ),
        Align(
          alignment: Alignment(1, 1),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 48),
            child: Text(
              'الرئيسية',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontFamily: 'AmiriQuran',
                  height: 1),
            ),
          ),
        ),
        Align(
          alignment: Alignment(-1, 1),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 53),
            child: Text(
              'حسابي',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontFamily: 'AmiriQuran',
                  height: 1),
            ),
          ),
        ),
        Align(
          alignment: Alignment(-0.1, 1),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 40),
            child: Text(
              'أضف إعلان',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontFamily: 'AmiriQuran',
                  height: 1),
            ),
          ),
        ),
      ],
    );
  }
}
